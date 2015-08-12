class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings, options: 'DEFAULT CHARSET=utf8' do |t|
      t.references  :architecture_style, index: true
      t.string      :architecture_style_description
      t.integer     :bathrooms
      t.integer     :bedrooms
      t.references  :brokerage, index: true
      t.integer     :building_unit_count
      t.references  :community, index: true
      t.integer     :condo_floor_num
      t.references  :county, index: true
      t.string      :currency_code
      t.text        :directions
      t.string      :disclaimer
      t.boolean     :disclose_address
      t.string      :elevation
      t.references  :foreclosure_status, index: true
      t.references  :franchise, index: true
      t.integer     :full_bathrooms
      t.string      :geocode_options
      t.integer     :half_bathrooms
      t.boolean     :has_attic
      t.boolean     :has_barbecue_area
      t.boolean     :has_basement
      t.boolean     :has_ceiling_fan
      t.boolean     :has_deck
      t.boolean     :has_disabled_access
      t.boolean     :has_dock
      t.boolean     :has_doorman
      t.boolean     :has_double_pane_windows
      t.boolean     :has_elevator
      t.boolean     :has_fireplace
      t.boolean     :has_garden
      t.boolean     :has_gated_entry
      t.boolean     :has_greenhouse
      t.boolean     :has_hot_tub_spa
      t.boolean     :has_intercom
      t.boolean     :has_jetted_bath_tub
      t.boolean     :has_lawn
      t.boolean     :has_mother_in_law
      t.boolean     :has_patio
      t.boolean     :has_pond
      t.boolean     :has_pool
      t.boolean     :has_porch
      t.boolean     :has_rv_parking
      t.boolean     :has_sauna
      t.boolean     :has_security_system
      t.boolean     :has_skylight
      t.boolean     :has_sports_court
      t.boolean     :has_sprinkler_system
      t.boolean     :has_vaulted_ceiling
      t.boolean     :has_wet_bar
      t.references  :import, index: true, foreign_key: true
      t.boolean     :is_cable_ready
      t.boolean     :is_new_construction
      t.boolean     :is_waterfront
      t.boolean     :is_wired
      t.decimal     :latitude, precision: 10, scale: 6
      t.string      :lead_routing_email
      t.text        :legal_description
      t.integer     :list_price, limit: 8
      t.integer     :list_price_low, limit: 8
      t.references  :listing_category, index: true
      t.date        :listing_date
      t.text        :listing_description
      t.string      :listing_key, null: false, limit: 255
      t.references  :listing_provider, index: true
      t.references  :listing_status, index: true
      t.text        :listing_title
      t.string      :listing_url
      t.integer     :living_area
      t.string      :living_area_unit, default: "squareFoot"
      t.decimal     :longitude, precision: 10, scale: 6
      t.float       :lot_size
      t.string      :lot_size_unit
      t.references  :multiple_listing_service, index: true
      t.string      :mls_number, limit: 255
      t.string      :modification_timestamp
      t.integer     :num_floors
      t.integer     :num_parking_spaces
      t.references  :office, index: true
      t.integer     :one_quarter_bathrooms
      t.string      :originating_system_key, limit: 255
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
    add_index :listings, :has_attic
    add_index :listings, :has_barbecue_area
    add_index :listings, :has_basement
    add_index :listings, :has_ceiling_fan
    add_index :listings, :has_deck
    add_index :listings, :has_disabled_access
    add_index :listings, :has_dock
    add_index :listings, :has_doorman
    add_index :listings, :has_double_pane_windows
    add_index :listings, :has_elevator
    add_index :listings, :has_fireplace
    add_index :listings, :has_garden
    add_index :listings, :has_gated_entry
    add_index :listings, :has_greenhouse
    add_index :listings, :has_hot_tub_spa
    add_index :listings, :has_intercom
    add_index :listings, :has_jetted_bath_tub
    add_index :listings, :has_lawn
    add_index :listings, :has_mother_in_law
    add_index :listings, :has_patio
    add_index :listings, :has_pond
    add_index :listings, :has_pool
    add_index :listings, :has_porch
    add_index :listings, :has_rv_parking
    add_index :listings, :has_sauna
    add_index :listings, :has_security_system
    add_index :listings, :has_skylight
    add_index :listings, :has_sports_court
    add_index :listings, :has_sprinkler_system
    add_index :listings, :has_vaulted_ceiling
    add_index :listings, :has_wet_bar
    add_index :listings, :is_cable_ready
    add_index :listings, :is_new_construction
    add_index :listings, :is_waterfront
    add_index :listings, :is_wired
    add_index :listings, :living_area
    add_index :listings, :lot_size
    add_index :listings, :listing_date
    add_index :listings, :latitude
    add_index :listings, :longitude
    add_index :listings, :originating_system_key
    add_index :listings, :year_built
  end
end