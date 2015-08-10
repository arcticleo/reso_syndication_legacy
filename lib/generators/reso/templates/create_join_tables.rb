class CreateJoinTables < ActiveRecord::Migration
  def change
    create_join_table :businesses, :listings
    add_index(:businesses_listings, [:business_id, :listing_id], unique: true)
    add_index(:businesses_listings, :listing_id)

    create_join_table :enumerations, :listings
    add_index(:enumerations_listings, [:enumeration_id, :listing_id], unique: true)
    add_index(:enumerations_listings, :listing_id)

    create_join_table :listing_offices, :listings
    add_index(:listing_offices_listings, [:listing_office_id, :listing_id], unique: true, name: "index_listings_offices_listing_id_office_id")
    add_index(:listing_offices_listings, :listing_id)

    create_join_table :listings, :participants
    add_index(:listings_participants, [:participant_id, :listing_id], unique: true)
    add_index(:listings_participants, :listing_id)

    create_join_table :listings, :places
    add_index(:listings_places, [:listing_id, :place_id], unique: true)
    add_index(:listings_places, :listing_id)

    create_join_table :places, :schools
    add_index(:places_schools, [:place_id, :school_id], unique: true)

  end
end