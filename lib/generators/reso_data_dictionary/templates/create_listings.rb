class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings, options: 'DEFAULT CHARSET=utf8' do |t|
      t.references  :architecture_style, index: true
      t.string      :architecture_style_description
      t.integer     :bathrooms
      t.integer     :bedrooms
      t.integer     :building_unit_count
      t.references  :community, index: true
      t.integer     :condo_floor_num
      t.references  :county, index: true
      t.string      :currency_code, default: "USD"
      t.text        :directions
      t.string      :disclaimer
      t.boolean     :disclose_address
      t.string      :elevation
      t.references  :foreclosure_status, index: true
      t.integer     :full_bathrooms
      t.string      :geocode_options
      t.integer     :half_bathrooms
      t.decimal     :latitude, precision: 10, scale: 6
      t.string      :lead_routing_email
      t.text        :legal_description
      t.integer     :list_price, limit: 8
      t.integer     :list_price_low, limit: 8
      t.references  :listing_category, index: true
      t.date        :listing_date
      t.text        :listing_description
      t.string      :listing_key, null: false
      t.references  :listing_provider, index: true
      t.references  :listing_status, index: true
      t.text        :listing_title
      t.string      :listing_url
      t.integer     :living_area
      t.string      :living_area_unit, default: "squareFoot"
      t.decimal     :longitude, precision: 10, scale: 6
      t.float       :lot_size
      t.string      :lot_size_unit
      t.references  :mls, index: true
      t.string      :mls_number
      t.string      :modification_timestamp
      t.integer     :num_floors
      t.integer     :num_parking_spaces
      t.integer     :one_quarter_bathrooms
      t.string      :parcel_info
      t.integer     :partial_bathrooms
      t.boolean     :permit_address_on_internet
      t.references  :property_sub_type, index: true
      t.string      :property_sub_type_description
      t.references  :property_type, index: true
      t.string      :property_type_description
      t.integer     :room_count
      t.boolean     :short_sale
      t.integer     :three_quarter_bathrooms
      t.string      :tracking_item
      t.boolean     :vow_address_display
      t.boolean     :vow_automated_valuation_display
      t.boolean     :vow_consumer_comment
      t.integer     :year_built
      t.integer     :year_updated
      t.references  :zoning_type, index: true

      t.timestamps
    end
    add_index :listings, :list_price
    add_index :listings, :listing_key
    add_index :listings, :mls_number
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