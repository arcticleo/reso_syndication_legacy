module Mapper
  module Reso

    def self.method_missing method_name, *args
      args[1][method_name]
    end
      
    def self.address queued_listing, listing
      if (result = Mapper::get_value(queued_listing, %w(Address)))
        listing.address ||= Address.new
        listing.address.assign_attributes({
          preference_order: result.drilldown('preference_order'),
          address_preference_order: result.drilldown('address_preference_order'),
          full_street_address: result.drilldown('FullStreetAddress'),
          unit_number: result.drilldown('UnitNumber'),
          city: result.drilldown('City'),
          state_or_province: result.drilldown('StateOrProvince'),
          postal_code: result.drilldown('PostalCode'),
          country: result.drilldown('Country')
        })
        listing.address
      end
    end
    
    def self.alternate_prices queued_listing, listing
      if (result = Mapper::get_repeaters(queued_listing, %w(AlternatePrices AlternatePrice)))
        result.map{|item| listing.alternate_prices.find_or_initialize_by(
          list_price: item.drilldown('AlternateListPrice'),
          currency_code: item.drilldown('AlternateListPrice currencyCode'),
          list_price_low: item.drilldown('AlternateListPriceLow'),
          currency_code_low: item.drilldown('AlternateListPriceLow currencyCode')
        )}
      end
    end

    def self.appliances queued_listing, listing
      Mapper::get_enums(queued_listing, %w(DetailedCharacteristics Appliances Appliance))
    end
    
    def self.architecture_style queued_listing, listing
      (result = Mapper::get_value(queued_listing, %w(DetailedCharacteristics ArchitectureStyle))) ? Mapper::architecture_styles(result) : nil
    end
    
    def self.architecture_style_description queued_listing, listing
      Mapper::get_value(queued_listing, %w(DetailedCharacteristics ArchitectureStyle otherDescription))
    end
    
    def self.bathrooms queued_listing, listing
      Mapper::get_value(queued_listing, %w(Bathrooms))
    end

    def self.bedrooms queued_listing, listing
      Mapper::get_value(queued_listing, %w(Bedrooms))
    end

    def self.brokerage queued_listing, listing
      get_reso_business(queued_listing, 'Brokerage')
    end

    def self.builder queued_listing, listing
      get_reso_business(queued_listing, 'Builder')
    end

    def self.building_unit_count queued_listing, listing
      Mapper::get_value(queued_listing, %w(DetailedCharacteristics BuildingUnitCount))
    end
    
    def self.condo_floor_num queued_listing, listing
      Mapper::get_value(queued_listing, %w(DetailedCharacteristics CondoFloorNum))
    end
    
    def self.cooling_systems queued_listing, listing
      Mapper::get_enums(queued_listing, %w(DetailedCharacteristics CoolingSystems CoolingSystem))
    end
    
    def self.county queued_listing, listing
      if (Mapper::get_value(queued_listing, %w(Location County)))
        county = County.find_or_initialize_by(
          name: Mapper::get_value(queued_listing, %w(Location County)),
          state_or_province: Mapper::get_value(queued_listing, %w(Address StateOrProvince)),
          country: Mapper::get_value(queued_listing, %w(Address Country))
        )
      else
        return nil
      end
    end

    def self.currency_code queued_listing, listing
      Mapper::get_value(queued_listing, %w(ListPrice currencyCode))
    end
    
    def self.directions queued_listing, listing
      Mapper::get_value(queued_listing, %w(Location Directions))
    end

    def self.disclaimer queued_listing, listing
      Mapper::get_value(queued_listing, %w(Disclaimer))
    end

    def self.disclose_address queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DiscloseAddress))
    end
    
    def self.elevation queued_listing, listing
      Mapper::get_value(queued_listing, %w(Location Elevation))
    end

    def self.expenses queued_listing, listing
      if (result = Mapper::get_repeaters(queued_listing, %w(Expenses Expense)))
        result.map{|item| listing.expenses.find_or_initialize_by(
          expense_category: Mapper::expense_categories(item['ExpenseCategory']),
          currency_period: Mapper::expense_categories(item['ExpenseValue']['currencyPeriod']),
          expense_value: item['ExpenseValue'].unwrap_attribute
        )}
      end
    end

    def self.exterior_types queued_listing, listing
      Mapper::get_enums(queued_listing, %w(DetailedCharacteristics ExteriorTypes ExteriorType))
    end
    
    def self.floor_coverings queued_listing, listing
      Mapper::get_enums(queued_listing, %w(DetailedCharacteristics FloorCoverings FloorCovering))
    end
    
    def self.foreclosure_status queued_listing, listing
      (result = Mapper::get_value(queued_listing, %w(ForeclosureStatus))) ? Mapper::foreclosure_statuses(result) : nil
    end
    
    def self.franchise queued_listing, listing
      get_reso_business(queued_listing, 'Franchise')
    end

    def self.full_bathrooms queued_listing, listing
      Mapper::get_value(queued_listing, %w(FullBathrooms))
    end

    def self.geocode_options queued_listing, listing
      Mapper::get_value(queued_listing, %w(Location GeocodeOptions))
    end

    def self.half_bathrooms queued_listing, listing
      Mapper::get_value(queued_listing, %w(HalfBathrooms))
    end

    def self.has_attic queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasAttic))
    end

    def self.has_barbecue_area queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasBarbecueArea))
    end

    def self.has_basement queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasBasement))
    end

    def self.has_ceiling_fan queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasCeilingFan))
    end

    def self.has_deck queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasDeck))
    end

    def self.has_disabled_access queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasDisabledAccess))
    end

    def self.has_dock queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasDock))
    end
      
    def self.has_doorman queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasDoorman))
    end

    def self.has_double_pane_windows queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasDoublePaneWindows))
    end

    def self.has_elevator queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasElevator))
    end

    def self.has_fireplace queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasFireplace))
    end

    def self.has_garden queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasGarden))
    end

    def self.has_gated_entry queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasGatedEntry))
    end

    def self.has_greenhouse queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasGreenhouse))
    end

    def self.has_hot_tub_spa queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasHotTubSpa))
    end

    def self.has_intercom queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics Intercom))
    end

    def self.has_jetted_bath_tub queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasJettedBathTub))
    end

    def self.has_lawn queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasLawn))
    end

    def self.has_mother_in_law queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasMotherInLaw))
    end

    def self.has_patio queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasPatio))
    end

    def self.has_pond queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasPond))
    end
      
    def self.has_pool queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasPool))
    end

    def self.has_porch queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasPorch))
    end

    def self.has_rv_parking queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasRVParking))
    end

    def self.has_sauna queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasSauna))
    end

    def self.has_security_system queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasSecuritySystem))
    end

    def self.has_skylight queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasSkylight))
    end

    def self.has_sports_court queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasSportsCourt))
    end

    def self.has_sprinkler_system queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasSprinklerSystem))
    end

    def self.has_vaulted_ceiling queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasVaultedCeiling))
    end

    def self.has_wet_bar queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics HasWetBar))
    end

    def self.heating_fuels queued_listing, listing
      Mapper::get_enums(queued_listing, %w(DetailedCharacteristics HeatingFuels HeatingFuel)).uniq
    end
    
    def self.heating_systems queued_listing, listing
      Mapper::get_enums(queued_listing, %w(DetailedCharacteristics HeatingSystems HeatingSystem)).uniq
    end

    def self.import queued_listing, listing
      queued_listing.import
    end

    def self.is_cable_ready queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics IsCableReady))
    end

    def self.is_new_construction queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics IsNewConstruction))
    end

    def self.is_waterfront queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics IsWaterfront))
    end

    def self.is_wired queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(DetailedCharacteristics IsWired))
    end

    def self.latitude queued_listing, listing
      Mapper::get_value(queued_listing, %w(Location Latitude))
    end

    def self.lead_routing_email queued_listing, listing
      Mapper::get_value(queued_listing, %w(LeadRoutingEmail))
    end

    def self.legal_description queued_listing, listing
      Mapper::get_value(queued_listing, %w(DetailedCharacteristics LegalDescription))
    end
    
    def self.list_price queued_listing, listing
      Mapper::get_value(queued_listing, %w(ListPrice))
    end
    
    def self.list_price_low queued_listing, listing
      Mapper::get_value(queued_listing, %w(ListPriceLow))
    end
    
    def self.listing_category queued_listing, listing
      (result = Mapper::get_value(queued_listing, %w(ListingCategory))) ? Mapper::listing_categories(result) : nil
    end

    def self.listing_date queued_listing, listing
      (result = Mapper::get_value(queued_listing, %w(ListingDate))) ? Chronic::parse(result).to_date : nil
    end
    
    def self.listing_description queued_listing, listing
      Mapper::get_value(queued_listing, %w(ListingDescription))
    end

    def self.listing_media queued_listing, listing, elements
      if (result = Mapper::get_repeaters(queued_listing, elements))
        result.map do |item|
          listing.send(elements.last.tableize).find_or_initialize_by(
            media_url: item.drilldown('MediaURL'),
            media_modification_timestamp: Chronic::parse(item.drilldown('MediaModificationTimestamp')),
            media_order_number: item.drilldown('MediaOrderNumber'),
            media_caption: item.drilldown('MediaCaption'),
            media_description: item.drilldown('MediaDescription')
          )
        end
      end
    end

    # TODO: Make ListingProvider and SourceProviderCategory Provider and ProviderCategory
    def self.listing_provider queued_listing, listing
      if Mapper::get_value(queued_listing, %w(ProviderName)).present?
        result = ListingProvider.find_or_initialize_by(
          name: Mapper::get_value(queued_listing, %w(ProviderName)),
          url: Mapper::get_value(queued_listing, %w(ProviderURL)),
          source_provider_category: Mapper::source_provider_categories(Mapper::get_value(queued_listing, %w(ProviderCategory)))
        )
      end
    end

    def self.listing_status queued_listing, listing
      (result = Mapper::get_value(queued_listing, %w(ListingStatus))) ? Mapper::listing_statuses(result) : nil
    end
    
    def self.listing_title queued_listing, listing
      Mapper::get_value(queued_listing, %w(ListingTitle))
    end
    
    def self.listing_url queued_listing, listing
      Mapper::get_value(queued_listing, %w(ListingURL))
    end

    def self.living_area queued_listing, listing
      Mapper::get_value(queued_listing, %w(LivingArea))
    end
    
    def self.living_area_unit queued_listing, listing
      Mapper::get_value(queued_listing, %w(LivingArea areaUnits))
    end

    def self.longitude queued_listing, listing
      Mapper::get_value(queued_listing, %w(Location Longitude))
    end
    
    def self.lot_size queued_listing, listing
      value = Mapper::get_value(queued_listing, %w(LotSize))
      value.to_s.to_f.zero? ? nil : value
    end

    def self.mls_number queued_listing, listing
      Mapper::get_value(queued_listing, %w(MlsNumber))
    end
    
    def self.modification_timestamp queued_listing, listing
      # TODO: Change from string to datetime
      Mapper::get_value(queued_listing, %w(ModificationTimestamp))
    end

    def self.multiple_listing_service queued_listing, listing
      if (Mapper::get_value(queued_listing, %w(MlsId)) || Mapper::get_value(queued_listing, %w(MlsName)))
        MultipleListingService.find_or_initialize_by(
          mls_id: Mapper::get_value(queued_listing, %w(MlsId)),
          mls_name: Mapper::get_value(queued_listing, %w(MlsName))
        )
      end
    end

    def self.neighborhoods queued_listing, listing
      if (result = Mapper::get_value(queued_listing, %w(Location Neighborhoods Neighborhood)))
        places = result.map do |item| 
          place = Neighborhood.find_or_initialize_by(
            city: Mapper::get_value(queued_listing, %w(Address City)),
            name: item.drilldown('Name'),
            state_or_province: Mapper::get_value(queued_listing, %w(Address StateOrProvince))
          )
          place.description = item.drilldown('Description')
          place
        end
      end
      places.present? ? places : []
    end

    def self.num_floors queued_listing, listing
      Mapper::get_value(queued_listing, %w(DetailedCharacteristics NumFloors))
    end
    
    def self.num_parking_spaces queued_listing, listing
      Mapper::get_value(queued_listing, %w(DetailedCharacteristics NumParkingSpaces))
    end
    
    def self.office queued_listing, listing
      if (result = Mapper::get_value(queued_listing, %w(Offices Office)))
        office = Office.find_or_initialize_by(
          office_identifier: result.drilldown('OfficeId'),
          name: (value = result.drilldown('Name') ? value : get_reso_business(queued_listing, 'Brokerage'))
        )
        office.assign_attributes({
          office_key: result.drilldown('OfficeKey'),
          level: result.drilldown('Level'),
          office_code_identifier: result.drilldown('OfficeCode OfficeCodeId'),
          corporate_name: result.drilldown('CorporateName'),
          broker_identifier: result.drilldown('BrokerId'),
          phone_number: result.drilldown('PhoneNumber'),
          website: result.drilldown('Website'),
        })
        office.address ||= Address.new
        office.address.assign_attributes({
          preference_order: result.drilldown('Address preference_order'),
          address_preference_order: result.drilldown('Address address_preference_order'),
          full_street_address: result.drilldown('Address FullStreetAddress'),
          unit_number: result.drilldown('Address UnitNumber'),
          city: result.drilldown('Address City'),
          state_or_province: result.drilldown('Address StateOrProvince'),
          postal_code: result.drilldown('Address PostalCode'),
          country: result.drilldown('Address Country')
        })
        office
      end
    end

    def self.one_quarter_bathrooms queued_listing, listing
      Mapper::get_value(queued_listing, %w(OneQuarterBathrooms))
    end

    # TODO: Figure out how to provide time zone for StartTime and EndTime 
    def self.open_houses queued_listing, listing
      if (result = Mapper::get_repeaters(queued_listing, %w(OpenHouses OpenHouse)))
        result.map do |open_house| 
          oh = listing.open_houses.find_or_initialize_by(
            showing_date: Chronic::parse(open_house['Date']).to_date,
            start_time: open_house['StartTime'],
            end_time: open_house['EndTime']
          )
          oh.description = open_house['Description']
          oh
        end
      end
    end

    def self.parcel_id queued_listing, listing
      Mapper::get_value(queued_listing, %w(Location ParcelId))
    end

    # TODO: Change participant_identifier to participant_id
    def self.participants queued_listing, listing
      if (result = Mapper::get_repeaters(queued_listing, %w(ListingParticipants Participant)))
        result.map do |item| 
          participant = Participant.find_or_initialize_by(
            first_name: item['FirstName'],
            last_name: item['LastName'],
            email: item['Email']
          )
          participant.assign_attributes({
            participant_key: item['ParticipantKey'],
            participant_identifier: item['ParticipantId'],
            participant_role: Mapper::participant_roles(item['Role']),
            primary_contact_phone: item['PrimaryContactPhone'],
            office_phone: item['OfficePhone'],
            fax: item['Fax'],
            website_url: item['WebsiteURL']
          })
          participant
        end
      end
    end

    def self.permit_address_on_internet queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(MarketingInformation PermitAddressOnInternet'))
    end
    
    def self.photos queued_listing, listing
      listing_media(queued_listing, listing, %w(Photos Photo))
    end

    def self.property_sub_type queued_listing, listing
      (result = Mapper::get_value(queued_listing, %w(PropertySubType))) ? Mapper::property_sub_types(result) : nil
    end
    
    def self.property_sub_type_description queued_listing, listing
      Mapper::get_value(queued_listing, %w(PropertySubType otherDescription))
    end
    
    def self.property_type queued_listing, listing
      (result = Mapper::get_value(queued_listing, %w(PropertyType))) ? Mapper::property_types(result) : nil
    end

    def self.property_type_description queued_listing, listing
      Mapper::get_value(queued_listing, %w(PropertyType otherDescription))
    end
    
    def self.roof_types queued_listing, listing
      Mapper::get_enums(queued_listing, %w(DetailedCharacteristics RoofTypes RoofType))
    end
    
    def self.room_count queued_listing, listing
      Mapper::get_value(queued_listing, %w(DetailedCharacteristics RoomCount))
    end
    
    def self.rooms queued_listing, listing
      if (result = Mapper::get_value(queued_listing, %w(DetailedCharacteristics Rooms Room)))
        rooms = Array(result).map{|room_category| Room.new(listing: listing, room_category: Mapper::room_categories(room_category))}
      end
      rooms ? rooms : []
    end
    
    def self.taxes queued_listing, listing
      if (result = Mapper::get_repeaters(queued_listing, %w(Taxes Tax)))
        result.map{|item| Tax.find_or_initialize_by(
          year: item['Year'],
          amount: item['Amount'],
          description: item['TaxDescription']
        )}
      end
    end

    def self.three_quarter_bathrooms queued_listing, listing
      Mapper::get_value(queued_listing, %w(ThreeQuarterBathrooms))
    end

    def self.videos queued_listing, listing
      listing_media(queued_listing, listing, %w(Videos Video))
    end

    def self.view_types queued_listing, listing
      Mapper::get_enums(queued_listing, %w(DetailedCharacteristics ViewTypes ViewType))
    end
    
    def self.virtual_tours queued_listing, listing
      listing_media(queued_listing, listing, %w(VirtualTours VirtualTour))
    end

    def self.vow_address_display queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(MarketingInformation VOWAutomatedValuationDisplay'))
    end

    def self.vow_automated_valuation_display queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(MarketingInformation VOWAddressDisplay'))
    end

    def self.vow_consumer_comment queued_listing, listing
      Mapper::get_boolean_value(queued_listing, %w(MarketingInformation VOWConsumerComment'))
    end
    
    def self.year_built queued_listing, listing
      Mapper::get_value(queued_listing, %w(YearBuilt))
    end

    def self.year_updated queued_listing, listing
      Mapper::get_value(queued_listing, %w(DetailedCharacteristics YearUpdated))
    end
    
    # Utilities

    def self.get_reso_business queued_listing, business_type
      if (result = Mapper::get_value(queued_listing, [business_type]))
        business = business_type.constantize.find_or_initialize_by(
          name: result.drilldown('Name'),
          phone: result.drilldown('Phone')
        )
        business.assign_attributes({
          email: result.drilldown('Email'),
          logo_url: result.drilldown('LogoURL'),
          website_url: result.drilldown('WebsiteURL')
        })
        business.address ||= Address.new
        business.address.assign_attributes({
          preference_order: result.drilldown('Address preference_order'),
          address_preference_order: result.drilldown('Address address_preference_order'),
          full_street_address: result.drilldown('Address FullStreetAddress'),
          unit_number: result.drilldown('Address UnitNumber'),
          city: result.drilldown('Address City'),
          state_or_province: result.drilldown('Address StateOrProvince'),
          postal_code: result.drilldown('Address PostalCode'),
          country: result.drilldown('Address Country')
        })
        business
      end
    end

  end
end