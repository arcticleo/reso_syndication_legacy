class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings, :options => 'DEFAULT CHARSET=utf8' do |t|
      t.integer :list_price, :limit => 8
      t.integer :list_price_low, :limit => 8
      t.string :listing_url
      t.references :listing_provider, index: true
      t.string :lead_routing_email
      t.integer :bedrooms
      t.integer :bathrooms
      t.references :property_type, index: true, :null => false
      t.references :property_sub_type, index: true, :null => false
      t.string :listing_key
      t.references :listing_category, index: true, :null => false
      t.references :listing_status, index: true, :null => false
      t.boolean :permit_address_on_internet
      t.boolean :vow_address_display
      t.boolean :vow_automated_valuation_display
      t.boolean :vow_consumer_comment
      t.boolean :disclose_address
      t.boolean :short_sale
      t.text :listing_description
      t.references :listing_service, index: true
      t.string :listing_service_identifier
      t.integer :living_area
      t.float :lot_size
      t.string :lot_size_unit
      t.date :listing_date
      t.text :listing_title
      t.integer :full_bathrooms
      t.integer :three_quarter_bathrooms
      t.integer :half_bathrooms
      t.integer :one_quarter_bathrooms
      t.integer :partial_bathrooms
      t.decimal :latitude, :precision => 16, :scale => 6
      t.decimal :longitude, :precision => 16, :scale => 6
      t.references :county, index: true
      t.references :community, index: true
      t.text :directions
      t.string :elevation
      t.string :geocode_options
      t.string :parcel_info
      t.references :zoning_type, index: true
      t.integer :year_built
      t.integer :year_updated
      t.integer :building_unit_count
      t.integer :num_floors
      t.integer :condo_floor_num
      t.integer :num_parking_spaces
      t.integer :room_count
      t.text :legal_description
      t.references :foreclosure_status, index: true
      t.references :architectural_style, index: true
      t.string :modification_timestamp

      t.timestamps
    end
    add_index :listings, :list_price
    add_index :listings, :listing_key
    add_index :listings, :listing_service_identifier
    add_index :listings, :bedrooms
    add_index :listings, :bathrooms
    add_index :listings, :living_area
    add_index :listings, :lot_size
    add_index :listings, :listing_date
    add_index :listings, :latitude
    add_index :listings, :longitude
    add_index :listings, :year_built
  end
end