class Import < ActiveRecord::Base

  require 'nokogiri'
  require 'open-uri'
  require 'open_uri_redirections'

  before_save :set_import_format
  belongs_to :import_format
  enum status: [ :active, :inactive, :running ]
  has_many :listings
  has_many :queued_listings
  validates_uniqueness_of :token

  def remove_listings_not_present fresh_listing_keys
    existing_listing_keys = self.listings.all.pluck(:listing_key)
    stale_listing_keys = existing_listing_keys.delete_if{|key| fresh_listing_keys.include? key }
    stale_listing_keys.each do |listing_key|
      Listing.find_by(listing_key: listing_key).destroy
    end
    stale_listing_keys
  end

  def set_import_format
    self.import_format = ImportFormat.find_by(name: 'reso') unless self.import_format.present?
  end

  def source_url_last_modified
    open(self.source_url, 
      http_basic_authentication: [self.source_user, self.source_pass], 
      allow_redirections: :all
    ){|f| return f.last_modified }
  end
  
  def new_source_data_exists?
    (self.source_url_last_modified > self.source_data_modified) ? true : false
  end

  def run_import
    if self.status == 'active'
      if self.new_source_data_exists?
        
        self.update_attribute(:status, :running)
        source_data_modified = self.source_url_last_modified

        l, count, found_listing_keys, stream = 0, 0, [], ''
        open_tag, close_tag = get_open_and_closing_tag_for self.repeating_element

        # Grab a file to work with
        filepath = download_feed_to_import self
        filepath = uncompress_and_return_new_filepath(filepath) if filepath.split('.').last.downcase == 'gz'
      
        # Grab the XML header to avoid namespace errors later 
        xml_header = get_xml_header filepath, self.repeating_element

        start_time = Time.now
        import_result = ImportResult.create(import: self, start_time: start_time, source_data_modified: source_data_modified)
        File.foreach(filepath) do |line|
          stream += line
          while (from_here = stream.index(open_tag)) && (to_there = stream.index(close_tag))
            xml = stream[from_here..to_there + (close_tag.length-1)]
            doc = Nokogiri::XML([xml_header, xml].join).remove_namespaces!
            found_listing_keys << create_queued_listing_and_return_listing_key(doc, self)
            stream.gsub!(xml, '')
          end
        end
        end_time = Time.now
        removed_listing_keys = self.remove_listings_not_present(found_listing_keys)
        import_result.assign_attributes({
          end_time: end_time,
          found_listing_keys: found_listing_keys,
          removed_listing_keys: removed_listing_keys.inspect
        })
        import_result.save
        self.assign_attributes({
          status: :active,
          source_data_modified: source_data_modified
        })
        self.save
        File.delete(filepath)
      end
    end
  end
  
  def download_feed_to_import import
    filename = import.source_url.split('/').last
    filepath = Rails.root.join('tmp', filename).to_s
    File.delete(filepath) if File.file? filepath
    open(filepath, 'wb') do |file|
      file << open(import.source_url, 
                http_basic_authentication: [import.source_user, import.source_pass], 
                allow_redirections: :all
              ).read
    end
    filepath
  end

  def get_open_and_closing_tag_for repeating_element
    ApplicationController.helpers.content_tag(repeating_element, "\n").split
  end

  def get_xml_header filepath, repeating_element
    stream = ''
    open_tag = get_open_and_closing_tag_for(repeating_element).first
    File.foreach(filepath) do |line|
      stream += line
      pos = stream.index(open_tag)
      return stream[0..pos-1] if pos
    end
    nil # Just in cases
  end

  def create_queued_listing_and_return_listing_key doc, import
    begin
      doc.css(import.repeating_element).each do |o|
        listing_data = {}
        Hash.from_xml(o.to_xml)[import.repeating_element].each_pair{|key, value| listing_data[key] = value }
        queued_listing = QueuedListing.new(import: import, listing_data: listing_data)
        queued_listing.save
        return Mapper::unique_identifier(queued_listing)
      end
    rescue Exception => e
      puts e.inspect
      exit if Rails.env.development?
      return nil
    end
  end
  
  def uncompress_and_return_new_filepath filepath
    output_path = [filepath, '.xml'].join
    File.delete(output_path) if File.file? output_path
    Zlib::GzipReader.open(filepath) do |gz|
      File.open(output_path, "w") do |g|
        IO.copy_stream(gz, g)
      end
    end
    File.delete(filepath)
    output_path
  end
  
end
