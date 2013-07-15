# RetsSyndication

rets_syndication
Michael Edlund, 2013

The rets_syndication gem provides models based on the RETS syndication format for exchange of real estate listing data, as defined by the Real Estate Standards Organization. 

Read more here:
http://www.reso.org/schemas-for-syndication

## Installation

Add this line to your application's Gemfile:

	gem 'rets_syndication', :path => "~/Projects/github/rets_syndication"

And then execute:

    $ bundle

Run the generator to copy migrations to your app:

    $ rails g rets:install

Run the migrations:

    $ rake db:migrate

Finally, populate the database with neccessary seed data and an example listing:

	$ rake rets:seed

## Usage

Fetch the demo listing:

	@listing = Listing.first

Access its data:

	@listing.addresses
	@listing.appliances
	@listing.architectural_style
	@listing.brokerages
	@listing.builders
	@listing.communities
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
	@listing.listing_services
	@listing.listing_status
	@listing.neighborhood
	@listing.office
	@listing.open_houses
	@listing.parking
	@listing.property_sub_type
	@listing.property_type
	@listing.roof_materials
	@listing.rooms
	@listing.schools
	@listing.taxes
	@listing.views

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
