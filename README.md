# RetsSyndication

rets_syndication - Michael Edlund, 2013

The rets_syndication gem provides models based on the RETS syndication format for exchange of real estate listing data, as defined by the Real Estate Standards Organization. 

Read more here:
http://www.reso.org/schemas-for-syndication

## Installation

Add this line to your application's Gemfile:

	gem 'rets_syndication', :path => "~/Projects/github/rets_syndication"

And then execute:

    $ bundle

Run the generator to copy migrations to your app:

    $ rails g rets_syndication:install

Run the migrations:

    $ rake db:migrate

Finally, populate the database with neccessary seed data and an example listing:

	$ rake rets_syndication:seed

## Usage

Fetch the demo listing:

	@listing = Listing.first

Access its direct attributes:

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

Access its data through relationships:

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
	@listing.listing_provider
	@listing.listing_service
	@listing.listing_status
	@listing.neighborhoods
	@listing.offices
	@listing.open_houses
	@listing.parking
	@listing.property_sub_type
	@listing.property_type
	@listing.roof_materials
	@listing.rooms
	@listing.taxes
	@listing.views

## TODO

	Zoning


