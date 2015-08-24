namespace :reso do

  require 'nokogiri'
  require 'open-uri'
  require 'open_uri_redirections'

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
  
  desc "Populate database with seed data."
  task :seed => [:load_enumerations, :seed_imports] 

  task :load_enumerations => [:environment] do
    require "csv"
    csv_text = File.read("#{Rails.root}/db/enumerations.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      row = row.to_hash.with_indifferent_access
      Enumeration.create!(row.to_hash.symbolize_keys)
        puts row.inspect
      end
      puts
  end

  task :seed_imports => [:environment] do
    imports = [{ name: "RESO Example", 
                 token: "reso",
                 import_format_id: ImportFormat.find_by(name: 'reso').id,
                 source_url: "https://app.listhub.com/syndication-docs/example.xml"
              }]
  
    imports.each do |import|
      @import = Import.new
      import.each_pair{|key, value| @import[key] = value }
      @import.save
    end
  end

  desc "Download and import data file for specified import."
  task :import, [:import_token] => [:environment] do |t, args|

    args.with_defaults(:import_token => "reso")
    import = Import.find_by(token: args.import_token)

    unless import.blank?
      l, count, incoming_listing_keys, stream = 0, 0, [], ''
      open_tag, close_tag = get_open_and_closing_tag_for import.repeating_element

      # Grab a file to work with
      filepath = download_feed_to_import import
      filepath = uncompress_and_return_new_filepath(filepath) if filepath.split('.').last.downcase == 'gz'
      
      # Grab the XML header to avoid namespace errors later 
      xml_header = get_xml_header filepath, import.repeating_element

      puts (start = Time.now)
      puts "Starting..." if Rails.env.development?
      File.foreach(filepath) do |line|
        stream += line
        while (from_here = stream.index(open_tag)) && (to_there = stream.index(close_tag))
          xml = stream[from_here..to_there + (close_tag.length-1)]
          doc = Nokogiri::XML([xml_header, xml].join).remove_namespaces!
          incoming_listing_keys << create_queued_listing_and_return_listing_key(doc, import)
          stream.gsub!(xml, '')
          if ((l += 1) % 1000).zero?
            puts "#{l}\t#{l/(Time.now - start)}" if Rails.env.development?
          end
          GC.start if (l % 100).zero?
        end
      end
      puts "Import speed: #{l/(Time.now - start)} listings/s" if Rails.env.development?
      puts "Found #{l} new listings." if Rails.env.development?
      stale_listing_keys = import.remove_listings_no_longer_present(incoming_listing_keys)
      puts "Removed #{stale_listing_keys.count} old listings." if Rails.env.development?
      File.delete(filepath)
    end
  end

end
