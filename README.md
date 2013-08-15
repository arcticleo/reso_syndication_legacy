# RETS Data

The rets_data gem provides models and data import based on the National Association of REALTORS(R) RETS syndication format for exchange of real estate listing data, as defined by the Real Estate Standards Organization. 

Read more here:
http://www.reso.org/schemas-for-syndication

## Installation

Add this line to your application's Gemfile:

	gem 'rets_data'

And then install:

    $ bundle

Run the generator to copy migrations to your app:

    $ rails g rets_data:install

Run the migrations:

    $ rake db:migrate

Populate the database with necessary seed data:

	$ rake rets_data:seed

You might want to populate the database with an example listing:

	$ rake rets_data:import

Alternatively, if you have an XML data file in the RETS syndication format, you can import it by specifying the path to it:

	$ rake rets_data:import[/Users/medlund/Downloads/somefile.xml]


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

	@listing.addresses
	@listing.appliances
	@listing.architectural_style
	@listing.brokerages
	@listing.builders
	@listing.community
	@listing.cooling_systems
	@listing.county
	@listing.expenses
	@listing.exterior_types
	@listing.flooring_materials
	@listing.foreclosure_status
	@listing.franchises
	@listing.heating_fuels
	@listing.heating_systems
	@listing.home_features
	@listing.listing_category
	@listing.listing_participants
	@listing.listing_photos
	@listing.listing_offices
	@listing.listing_provider
	@listing.listing_service
	@listing.listing_status
	@listing.listing_videos
	@listing.neighborhoods
	@listing.open_houses
	@listing.parking
	@listing.property_sub_type
	@listing.property_type
	@listing.roof_materials
	@listing.rooms
	@listing.taxes
	@listing.views
	@listing.virtual_tours

## License

RETS Data is released under the [MIT License](http://www.opensource.org/licenses/MIT).
  

