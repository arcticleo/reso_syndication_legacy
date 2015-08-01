# RESO Data Dictionary

The reso_data_dictionary gem provides models and data import based on the National Association of REALTORS(R) RETS syndication format for exchange of real estate listing data, as defined by the Real Estate Standards Organization. Supports AWS SQS (Simple Queue Service) for queuing and parallel processing for fast import of large data sets.

Read more here:
http://www.reso.org/schemas-for-syndication

## Installation

Add this line to your application's Gemfile:

	gem 'reso_data_dictionary'

And then install:

    $ bundle

Run the generator to copy migrations to your app:

    $ rails g reso_data_dictionary:install

Create the database:

    $ rake db:create

Run the migrations:

    $ rake db:migrate

Populate the database with necessary seed data:

	$ rake reso:seed

You might want to populate the database with an example listing:

	$ rake reso:process

Alternatively, if you have an XML data file in the RETS syndication format, you can import it by specifying the absolute path to it:

	$ rake reso:process[/Users/medlund/Downloads/somefile.xml]

If your XML data file is large, you can speed up import significantly by setting up an Amazon AWS account and take advantage of AWS SQS (Simple Queue Service) to queue each listing and then launch several import workers that poll the queue and import your listings in parallel.

To do this, first make sure that your application has set values for AWS_ACCESS_KEY_ID and AWS_SECRET_KEY.

Secondly, add a AWS SQS queue name to the rake task:

	$ rake reso:process[/Users/medlund/Downloads/somefile.xml,rets_import_queue]

Note the lack of space between path and queue name.

Thirdly, launch as many parallel workers as you see fit:

	$ rake reso:process_aws_sqs_queue[rets_import_queue]

In my own use case with a 350 MB XML data file, import was sped up from ~3.5 hours to ~35 min by using AWS SQS with six import workers.


## Usage

Fetch a listing:

	@listing = Listing.first

Access direct attributes:

	@listing.list_price
	@listing.list_price_low
	@listing.listing_url
	@listing.lead_routing_email
	@listing.bedrooms
	@listing.bathrooms
	@listing.listing_key
	@listing.permit_address_on_internet
	@listing.vow_address_display
	@listing.vow_automated_valuation_display
	@listing.vow_consumer_comment
	@listing.disclose_address
	@listing.short_sale
	@listing.listing_description
	@listing.listing_service_identifier
	@listing.living_area
	@listing.lot_size
	@listing.lot_size_unit
	@listing.listing_date
	@listing.listing_title
	@listing.full_bathrooms
	@listing.three_quarter_bathrooms
	@listing.half_bathrooms
	@listing.one_quarter_bathrooms
	@listing.partial_bathrooms
	@listing.latitude
	@listing.longitude
	@listing.directions
	@listing.elevation
	@listing.geocode_options
	@listing.parcel_info
	@listing.year_built
	@listing.year_updated
	@listing.building_unit_count
	@listing.num_floors
	@listing.condo_floor_num
	@listing.num_parking_spaces
	@listing.room_count
	@listing.legal_description

Access related models:

	@listing.address
	@listing.appliances
	@listing.architecture_style
	@listing.brokerage
	@listing.builders
	@listing.community
	@listing.cooling_systems
	@listing.county
	@listing.expenses
	@listing.exterior_types
	@listing.floor_coverings
	@listing.foreclosure_status
	@listing.franchises
	@listing.heating_fuels
	@listing.heating_systems
	@listing.home_features
	@listing.listing_category
	@listing.listing_office
	@listing.listing_provider
	@listing.listing_service
	@listing.listing_status
	@listing.neighborhoods
        @listing.offices
	@listing.open_houses
	@listing.parking
	@listing.participants
	@listing.photos
	@listing.property_sub_type
	@listing.property_type
	@listing.roof_types
	@listing.rooms
	@listing.taxes
	@listing.videos
	@listing.view_types
	@listing.virtual_tours

Other:

	@brokerage.address
	@builder.address
	@franchise.address

## License

MIT License. Copyright 2013 Michael Edlund, medlund@mac.com.

  

