class CreateJoinTables < ActiveRecord::Migration
  def change
    create_join_table :addresses, :businesses
    add_index(:addresses_businesses, [:address_id, :business_id], :unique => true)

    create_join_table :addresses, :listings
    add_index(:addresses_listings, [:address_id, :listing_id], :unique => true)

    create_join_table :addresses, :offices
    add_index(:addresses_offices, [:address_id, :office_id], :unique => true)

    create_join_table :businesses, :listings
    add_index(:businesses_listings, [:business_id, :listing_id], :unique => true)

    create_join_table :enumerals, :listings
    add_index(:enumerals_listings, [:enumeral_id, :listing_id], :unique => true)

    create_join_table :listing_participants, :listings
    add_index(:listing_participants_listings, [:listing_participant_id, :listing_id], :unique => true, :name => "index_participants_listings_listing_participant_id_listing_id")

    create_join_table :listings, :offices
    add_index(:listings_offices, [:listing_id, :office_id], :unique => true)

    create_join_table :listings, :places
    add_index(:listings_places, [:listing_id, :place_id], :unique => true)

    create_join_table :places, :schools
    add_index(:places_schools, [:place_id, :school_id], :unique => true)

  end
end