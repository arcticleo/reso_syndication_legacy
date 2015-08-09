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
  
  def process_item xml, xml_header, import
    begin
      doc = Nokogiri::XML([xml_header, xml].join).remove_namespaces!
      doc.css(import.repeating_element).each do |o|
        listing_data = Hash.new
        listing = Hash.from_xml(o.to_xml)
        object = import.queued_listings.new
        listing[import.repeating_element].each_pair{|key, value| listing_data[key] = value }
        object.listing_data = listing_data
        object.save
      end
    rescue Exception => e
      puts e.inspect
      exit
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
  task :seed => [:seed_imports, :load_enumerals] 

  task :load_enumerals => [:environment] do
    require "csv"
    csv_text = File.read("#{Rails.root}/db/enumerals.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      row = row.to_hash.with_indifferent_access
      Enumeral.create!(row.to_hash.symbolize_keys)
        puts row.inspect
      end
      puts
  end

  task :seed_imports => [:environment] do
    imports = [{ name: "ListHub Example", token: "listhub-example", source_format: "reso", repeating_element: "Listing", unique_identifier: "ListingKey", source_url: "https://app.listhub.com/syndication-docs/example.xml"}]
  
    imports.each do |import|
      @import = Import.new
      import.each_pair{|key, value| @import[key] = value }
      @import.save
    end
  end

  desc "Download and import data file for specified import."
  task :import, [:import_token] => [:environment] do |t, args|

    args.with_defaults(:import_token => "listhub-example")
    import = Import.find_by(token: args.import_token)

    unless import.blank?
      count, stream = 0, ''
      open_tag, close_tag = get_open_and_closing_tag_for import.repeating_element

      # Grab a file to work with
      filepath = download_feed_to_import import
      filepath = uncompress_and_return_new_filepath(filepath) if filepath.split('.').last.downcase == 'gz'
      
      # Grab the XML header to avoid namespace errors later 
      xml_header = get_xml_header filepath, import.repeating_element

      start = Time.now

      l = 0
      File.foreach(filepath) do |line|
        stream += line
        while (from_here = stream.index(open_tag)) && (to_there = stream.index(close_tag))
          xml = stream[from_here..to_there + (close_tag.length-1)]
          process_item xml, xml_header, import
          stream.gsub!(xml, '')
          if (l += 1) == 1000
            puts "#{l} - #{l/(Time.now - start)} listings/s"
            exit
          end
        end
      end
      File.delete(filepath)
    end
  end

    
#    existing_listing_keys = Listing.all.select(:listing_key).pluck(:listing_key)
#    (existing_listing_keys - incoming_listing_keys).each do |orphaned_listing_key|
#      @listing = Listing.find_by(:listing_key => orphaned_listing_key)
#      puts "Deleting expired: #{@listing.listing_key}".color(:red) + " - #{@listing.listing_title}"
#      @listing.destroy
#    end

end
