# RESO Data Dictionary

The RESO Data Dictionary gem is an ongoing effort to provide data models and data import based on the Real Estate Standardization Organization Data Dictionary syndication format for exchange of real estate listing data.

Read more here:
http://www.reso.org/schemas-for-syndication

This gem has been written for MySQL. If you test it using another RDBMS, let me know the result.


## Installation

Add this line to your application's Gemfile:

	gem 'reso'

And then install:

    $ bundle

Run the generator to copy migrations to your app:

    $ rails g reso:install

Create the database:

    $ rake db:create

Run the migrations:

    $ rake db:migrate

Populate the database with necessary seed data:

	$ rake reso:seed

Populate the database with an example listing:

	$ rake reso:import

This will download and install an example listing in the RESO format, as provided by ListHub, the largest US listing syndicator. The information needed is populated by the seed task through the Import model. If you want to add your own import, you would open the console and create an import:

	> Import.create(token: 'myimport', name: 'My Import', source_url: 'http://somewebsite.com/myfeed.xml')

You would then import it by passing the token value to the import rake task:

	$ rake reso:import[myimport]


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
	@listing.alternate_prices
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
	@listing.multiple_listing_service
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

MIT License. Copyright 2013-2015 Michael Edlund, medlund@mac.com.

  

