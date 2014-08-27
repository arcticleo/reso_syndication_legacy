namespace :reso do

  require 'aws-sdk'
  require 'nokogiri'

  desc "Populate database with seed data."
  task :seed => [:load_enumerals] 

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

  desc "Poll and import listings from AWS SQS queue."
  task :process_aws_sqs_queue, [:aws_sqs_queue_name] => [:environment] do |t, args|
    AWS_ACCESS_KEY_ID = nil unless defined? AWS_ACCESS_KEY_ID
    AWS_SECRET_KEY = nil unless defined? AWS_SECRET_KEY
    case (AWS_ACCESS_KEY_ID && AWS_SECRET_KEY && args.aws_sqs_queue_name.present?)
    when true
      aws = AWS::SQS.new(:access_key_id => AWS_ACCESS_KEY_ID, :secret_access_key => AWS_SECRET_KEY)
      queue = aws.queues.create(args.aws_sqs_queue_name)
      puts "Polling AWS SQS queue '#{args.aws_sqs_queue_name}'...".color(:green)
      queue.poll do |msg|
        p = Nokogiri::XML(msg.body)
        @listing = Listing.find_by(:listing_key => p.children.at_css('ListingKey').try(:inner_text))
        if (@listing.blank? || @listing.modification_timestamp != p.children.at_css('ModificationTimestamp').try(:inner_text))
          if Listing::import_or_update_item(p)
           puts "Imported: #{p.children.at_css('ListingKey').try(:inner_text)}".color(:green)
          else
           puts "Failed: #{p.children.at_css('ListingKey').try(:inner_text)}".color(:red)
          end
        else
          puts "Skipping: #{p.children.at_css('ListingKey').try(:inner_text)}".color(:yellow)
        end
      end
    else
      puts "Could not launch import worker. Make sure AWS_ACCESS_KEY_ID, AWS_SECRET_KEY and aws_queue_name are present.".color(:red)
      puts "Example: rake reso_data_dictionary:process_aws_sqs_queue[some_queue_name]\n".color(:red)
    end
  end

  desc "Import or queue listings from XML source file."
  task :process, [:path, :aws_sqs_queue_name] => [:environment] do |t, args|
    AWS_ACCESS_KEY_ID = nil unless defined? AWS_ACCESS_KEY_ID
    AWS_SECRET_KEY = nil unless defined? AWS_SECRET_KEY
    case (AWS_ACCESS_KEY_ID && AWS_SECRET_KEY && args.aws_sqs_queue_name.present?)
    when true
      target = "AWS"
      aws = AWS::SQS.new(:access_key_id => AWS_ACCESS_KEY_ID, :secret_access_key => AWS_SECRET_KEY)
      queue = aws.queues.create(args.aws_sqs_queue_name)
    else
      target = "DB"
    end
    incoming_listing_keys = Array.new
    existing_listing_keys = Array.new
    args.with_defaults(:path => "#{Rails.root}/db/example.xml")
    @doc = Nokogiri::XML(f = File.open(args.path))
    @doc.remove_namespaces!

    @doc.css('Listing').each do |p|
      incoming_listing_keys << p.children.at_css('ListingKey').try(:inner_text)
      @listing = Listing.find_by(:listing_key => p.children.at_css('ListingKey').try(:inner_text))
      if (@listing.blank? || @listing.modification_timestamp != p.children.at_css('ModificationTimestamp').try(:inner_text))
        case target
        when "AWS"
          Thread.new{ queue.send_message(p.serialize) }
          puts "AWS Queued: #{p.children.at_css('ListingKey').try(:inner_text)}".color(:green) + " - #{p.children.at_css('ListingTitle').try(:inner_text)}"
        when "DB"
          if Listing::import_or_update_item(p)
           puts "Imported: #{p.children.at_css('ListingKey').try(:inner_text)}".color(:green) + " - #{p.children.at_css('ListingTitle').try(:inner_text)}"
          else
           puts "FAILED: #{p.children.at_css('ListingKey').try(:inner_text)}".color(:red) + " - #{p.children.at_css('ListingTitle').try(:inner_text)}"
          end
        else
          puts "Unknown target.".color(:gray)
        end
      else
        puts "#{target} Skipped: #{p.children.at_css('ListingKey').try(:inner_text)}".color(:yellow) + " - #{p.children.at_css('ListingTitle').try(:inner_text)}"
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
