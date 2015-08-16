module Mapper
  RESO_LISTING_ATTRIBUTES = %w(
    address
    alternate_prices
    appliances
    architecture_style
    architecture_style_description
    bathrooms
    bedrooms
    brokerage
    builder
    building_unit_count
    condo_floor_num
    cooling_systems
    county
    currency_code
    directions
    disclaimer
    disclose_address
    elevation
    expenses
    exterior_types
    floor_coverings
    foreclosure_status
    franchise
    full_bathrooms
    geocode_options
    half_bathrooms
    has_attic
    has_barbecue_area
    has_basement
    has_ceiling_fan
    has_deck
    has_disabled_access
    has_dock
    has_doorman
    has_double_pane_windows
    has_elevator
    has_fireplace
    has_garden
    has_gated_entry
    has_greenhouse
    has_hot_tub_spa
    has_intercom
    has_jetted_bath_tub
    has_lawn
    has_mother_in_law
    has_patio
    has_pond
    has_pool
    has_porch
    has_rv_parking
    has_sauna
    has_security_system
    has_skylight
    has_sports_court
    has_sprinkler_system
    has_vaulted_ceiling
    has_wet_bar
    heating_fuels
    heating_systems
    import
    is_cable_ready
    is_new_construction
    is_waterfront
    is_wired
    latitude
    lead_routing_email
    legal_description
    list_price
    list_price_low
    listing_category
    listing_date
    listing_description
    listing_provider
    listing_status
    listing_title
    listing_url
    living_area
    living_area_unit
    longitude
    lot_size
    mls_number
    multiple_listing_service
    modification_timestamp
    neighborhoods
    num_floors
    num_parking_spaces
    office
    one_quarter_bathrooms
    open_houses
    parcel_info
    participants
    permit_address_on_internet
    photos
    property_sub_type 
    property_sub_type_description
    property_type
    property_type_description
    roof_types
    room_count
    rooms
    taxes
    three_quarter_bathrooms
    videos
    view_types
    virtual_tours
    vow_address_display
    vow_automated_valuation_display
    vow_consumer_comment
    year_built
    year_updated
  )

  def self.fetch_enumerations class_name
    Rails.cache.fetch(class_name, expires_in: 1.hours) do
      enums = {}
      class_name.constantize.all.map{|item| enums[item.name] = item}
      enums
    end
  end

  def self.address_types
    fetch_enumerations 'AddressType'
  end
  
  def self.appliances
    fetch_enumerations 'Appliance'
  end

  def self.architecture_styles
    fetch_enumerations 'ArchitectureStyle'
  end
  
  def self.area_units
    fetch_enumerations 'AreaUnit'
  end
  
  def self.cooling_systems
    fetch_enumerations 'CoolingSystem'
  end
  
  def self.currency_periods
    fetch_enumerations 'CurrencyPeriod'
  end
  
  def self.expense_categories
    fetch_enumerations 'ExpenseCategory'
  end
  
  def self.exterior_types
    fetch_enumerations 'ExteriorType'
  end
  
  def self.floor_coverings
    fetch_enumerations 'FloorCovering'
  end
  
  def self.foreclosure_statuses
    fetch_enumerations 'ForeclosureStatus'
  end
  
  def self.gender
    fetch_enumerations 'Gender'
  end
  
  def self.heating_fuels
    fetch_enumerations 'HeatingFuel'
  end
  
  def self.heating_systems
    fetch_enumerations 'HeatingSystem'
  end
  
  def self.home_features
    fetch_enumerations 'HomeFeature'
  end
  
  def self.import_formats
    fetch_enumerations 'ImportFormat'
  end
  
  def self.license_categories
    fetch_enumerations 'LicenseCategory'
  end
  
  def self.listing_categories
    fetch_enumerations 'ListingCategory'
  end
  
  def self.listing_statuses
    fetch_enumerations 'ListingStatus'
  end
  
  def self.parkings
    fetch_enumerations 'Parking'
  end
  
  def self.participant_roles
    fetch_enumerations 'ParticipantRole'
  end
  
  def self.property_sub_types
    fetch_enumerations 'PropertySubType'
  end
  
  def self.property_types
    fetch_enumerations 'PropertyType'
  end
  
  def self.roof_types
    fetch_enumerations 'RoofType'
  end
  
  def self.room_categories
    fetch_enumerations 'RoomCategory'
  end
  
  def self.school_categories
    fetch_enumerations 'SchoolCategory'
  end
  
  def self.source_provider_categories
    fetch_enumerations 'SourceProviderCategory'
  end
  
  def self.view_types
    fetch_enumerations 'ViewType'
  end

end