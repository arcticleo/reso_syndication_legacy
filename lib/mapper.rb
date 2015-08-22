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

  def self.fetch_enumeration class_name, item_name
    Rails.cache.fetch([class_name, item_name], expires_in: 1.hours) do
      class_name.constantize.find_by(name: item_name)
    end
  end

  def self.address_types item_name
    fetch_enumeration 'AddressType', item_name
  end
  
  def self.appliances item_name
    fetch_enumeration 'Appliance', item_name
  end

  def self.architecture_styles item_name
    fetch_enumeration 'ArchitectureStyle', item_name
  end
  
  def self.area_units item_name
    fetch_enumeration 'AreaUnit', item_name
  end
  
  def self.cooling_systems item_name
    fetch_enumeration 'CoolingSystem', item_name
  end
  
  def self.currency_periods item_name
    fetch_enumeration 'CurrencyPeriod', item_name
  end
  
  def self.expense_categories item_name
    fetch_enumeration 'ExpenseCategory', item_name
  end
  
  def self.exterior_types item_name
    fetch_enumeration 'ExteriorType', item_name
  end
  
  def self.floor_coverings item_name
    fetch_enumeration 'FloorCovering', item_name
  end
  
  def self.foreclosure_statuses item_name
    fetch_enumeration 'ForeclosureStatus', item_name
  end
  
  def self.gender item_name
    fetch_enumeration 'Gender', item_name
  end
  
  def self.heating_fuels item_name
    fetch_enumeration 'HeatingFuel', item_name
  end
  
  def self.heating_systems item_name
    fetch_enumeration 'HeatingSystem', item_name
  end
  
  def self.home_features item_name
    fetch_enumeration 'HomeFeature', item_name
  end
  
  def self.import_formats item_name
    fetch_enumeration 'ImportFormat', item_name
  end
  
  def self.license_categories item_name
    fetch_enumeration 'LicenseCategory', item_name
  end
  
  def self.listing_categories item_name
    fetch_enumeration 'ListingCategory', item_name
  end
  
  def self.listing_statuses item_name
    fetch_enumeration 'ListingStatus', item_name
  end
  
  def self.parkings item_name
    fetch_enumeration 'Parking', item_name
  end
  
  def self.participant_roles item_name
    fetch_enumeration 'ParticipantRole', item_name
  end
  
  def self.property_sub_types item_name
    fetch_enumeration 'PropertySubType', item_name
  end
  
  def self.property_types item_name
    fetch_enumeration 'PropertyType', item_name
  end
  
  def self.roof_types item_name
    fetch_enumeration 'RoofType', item_name
  end
  
  def self.room_categories item_name
    fetch_enumeration 'RoomCategory', item_name
  end
  
  def self.school_categories item_name
    fetch_enumeration 'SchoolCategory', item_name
  end
  
  def self.source_provider_categories item_name
    fetch_enumeration 'SourceProviderCategory', item_name
  end
  
  def self.view_types item_name
    fetch_enumeration 'ViewType', item_name
  end
  
  def self.unique_identifier queued_listing
    (result = Mapper::get_value(queued_listing, queued_listing.import.unique_identifier.split(' ')))
  end

  def self.get_boolean_value queued_listing, elements
    (result = Mapper::get_value(queued_listing, elements)) ? result.to_s.to_bool : nil
  end
  
  def self.get_value queued_listing, elements
    if elements.count.eql?(1)
      get_simple_value(queued_listing, elements.first)
    else
      get_subvalue(queued_listing, elements.first, elements[1..-1])
    end
  end
  
  def self.get_simple_value queued_listing, element
    if (value = queued_listing.listing_data[element])
      value.unwrap_attribute
    end
  end
  
  def self.get_subvalue queued_listing, element, child_elements
    if (value = get_simple_value(queued_listing, element))
      if (subvalue = child_elements.inject(value){|v, e| v[e] ? v[e] : Hash.new })
        subvalue.present? ? subvalue.unwrap_attribute : nil
      end
    end
  end

  def self.get_repeaters queued_listing, elements
    if (value = Mapper::get_value(queued_listing, elements[0..-2]))
      (result = value.drilldown(elements.last)) ? (result.is_a?(Array) ? result : [result]) : nil
    else
      return []
    end
  end
  
  def self.get_enums queued_listing, elements
    if (result = get_repeaters(queued_listing, elements))
      enums = result.map{|name| Mapper.send(elements.last.tableize, name)}
    end
    enums ? enums.compact : nil
  end

end