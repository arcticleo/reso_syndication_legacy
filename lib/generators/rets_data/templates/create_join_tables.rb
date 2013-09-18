class CreateJoinTables < ActiveRecord::Migration
  def change
    create_join_table :addresses, :businesses
    add_index(:addresses_businesses, [:address_id, :business_id], :unique => true)

    create_join_table :addresses, :listings
    add_index(:addresses_listings, [:address_id, :listing_id], :unique => true)

    create_join_table :addresses, :listing_offices
    add_index(:addresses_listing_offices, [:address_id, :listing_office_id], :unique => true, :name => "index_address_offices_address_id_office_id")

    create_join_table :businesses, :listings
    add_index(:businesses_listings, [:business_id, :listing_id], :unique => true)

    create_join_table :enumerals, :listings
    add_index(:enumerals_listings, [:enumeral_id, :listing_id], :unique => true)

    create_join_table :listing_offices, :listings
    add_index(:listing_offices_listings, [:listing_office_id, :listing_id], :unique => true, :name => "index_listings_offices_listing_id_office_id")

    create_join_table :listings, :participants
    add_index(:listings_participants, [:participant_id, :listing_id], :unique => true)

    create_join_table :listings, :places
    add_index(:listings_places, [:listing_id, :place_id], :unique => true)

    create_join_table :places, :schools
    add_index(:places_schools, [:place_id, :school_id], :unique => true)

  end
end