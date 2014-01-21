namespace :rets_data do

	task :load_enumerals => [:environment] do
		require "csv"
		csv_text = File.read("#{Rails.root}/db/enumerals.csv")
		csv = CSV.parse(csv_text, :headers => true)
		csv.each do |row|
        	row = row.to_hash.with_indifferent_access
			Enumeral.create!(row.to_hash.symbolize_keys)
            puts row.inspect
        end
        puts ""
    end

  desc "Validate RETS Syndication data file."
	task :validate, [:path] => [:environment] do |t, args|
    require 'nokogiri'
    require 'open-uri'

    args.with_defaults(:path => "#{Rails.root}/db/example.xml")

    xsd = Nokogiri::XML::Schema(open('http://rets.org/xsd/Syndication/2012-03/Syndication.xsd'))
    doc = Nokogiri::XML(f = File.open(args.path))

    xsd.validate(doc).each do |error|
      puts error.message
    end
  end

	desc "Populate database with seed data."
	task :seed => [:load_enumerals] do
	end

	desc "Import listings in RETS Syndication format."
	task :import, [:path] => [:environment] do |t, args|
	  require 'nokogiri'
	  incoming_listing_keys = Array.new
	  existing_listing_keys = Array.new
    args.with_defaults(:path => "#{Rails.root}/db/example.xml")
	  @doc = Nokogiri::XML(f = File.open(args.path))

    @doc.css('Listing').each do |p|
      incoming_listing_keys << p.children.at_css('ListingKey').try(:inner_text)
      @listing = Listing.find_by(:listing_key => p.children.at_css('ListingKey').try(:inner_text))
      if (@listing.blank? || @listing.modification_timestamp != p.children.at_css('ModificationTimestamp').try(:inner_text))
       if Listing::import_or_update_item(p)
         puts "Imported: #{p.children.at_css('ListingKey').try(:inner_text)}".color(:green) + " - #{p.children.at_css('ListingTitle').try(:inner_text)}"
       else
         puts "FAILED: #{p.children.at_css('ListingKey').try(:inner_text)}".color(:red) + " - #{p.children.at_css('ListingTitle').try(:inner_text)}"
       end
     else
       puts "Skipping: #{p.children.at_css('ListingKey').try(:inner_text)}".color(:yellow) + " - #{p.children.at_css('ListingTitle').try(:inner_text)}"
     end
    end
    
    existing_listing_keys = Listing.all.select(:listing_key).pluck(:listing_key)
    (existing_listing_keys - incoming_listing_keys).each do |orphaned_listing_key|
      @listing = Listing.find_by(:listing_key => orphaned_listing_key)
      puts "Deleting expired: #{@listing.listing_key}".color(:red) + " - #{@listing.listing_title}"
      @listing.destroy
    end

  end
  
end
