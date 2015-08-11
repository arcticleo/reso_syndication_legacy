module Mapper
  module Reso
    
    def self.address queued_listing, listing
      if (result = get_value(queued_listing, %w(Address)))
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
      if (result = get_repeaters(queued_listing, %w(AlternatePrices AlternatePrice)))
        result.map{|item| listing.alternate_prices.find_or_initialize_by(
          list_price: item.drilldown('AlternateListPrice'),
          currency_code: item.drilldown('AlternateListPrice currencyCode'),
          list_price_low: item.drilldown('AlternateListPriceLow'),
          currency_code_low: item.drilldown('AlternateListPriceLow currencyCode')
        )}
      end
    end

    def self.appliances queued_listing
      (result = get_enums(queued_listing, %w(DetailedCharacteristics Appliances Appliance))) ? result : nil
    end
    
    def self.architecture_style queued_listing
      (result = unwrap_attribute(get_value(queued_listing, %w(DetailedCharacteristics ArchitectureStyle)))) ? ArchitectureStyle.find_by_name(result) : nil
    end
    
    def self.architecture_style_description queued_listing
      (result = get_value(queued_listing, %w(DetailedCharacteristics ArchitectureStyle otherDescription))) ? result : nil
    end
    
    def self.bathrooms queued_listing
      (result = get_value(queued_listing, %w(Bathrooms))) ? result.to_i : nil
    end

    def self.bedrooms queued_listing
      (result = get_value(queued_listing, %w(Bedrooms))) ? result.to_i : nil
    end

    def self.brokerage queued_listing
      if (result = get_value(queued_listing, %w(Brokerage)))
        brokerage = Brokerage.find_or_initialize_by(
          name: result.drilldown('Name')
        )
        brokerage.assign_attributes({
          phone: result.drilldown('Phone'),
          email: result.drilldown('Email'),
          website_url: result.drilldown('WebsiteURL'),
          logo_url: result.drilldown('LogoURL')
        })
        brokerage.address ||= Address.new
        brokerage.address.assign_attributes({
          preference_order: result.drilldown('Address preference_order'),
          address_preference_order: result.drilldown('Address address_preference_order'),
          full_street_address: result.drilldown('Address FullStreetAddress'),
          unit_number: result.drilldown('Address UnitNumber'),
          city: result.drilldown('Address City'),
          state_or_province: result.drilldown('Address StateOrProvince'),
          postal_code: result.drilldown('Address PostalCode'),
          country: result.drilldown('Address Country')
        })
        brokerage
      end
    end
    
    def self.building_unit_count queued_listing
      (result = get_value(queued_listing, %w(DetailedCharacteristics BuildingUnitCount))) ? result.to_i : nil
    end
    
    def self.condo_floor_num queued_listing
      (result = get_value(queued_listing, %w(DetailedCharacteristics CondoFloorNum))) ? result.to_i : nil
    end
    
    def self.cooling_systems queued_listing
      (result = get_enums(queued_listing, %w(DetailedCharacteristics CoolingSystems CoolingSystem))) ? result : nil
    end
    
    def self.county queued_listing
      if (get_value(queued_listing, %w(Location County)))
        County.find_or_initialize_by(
          name: get_value(queued_listing, %w(Location County)),
          state_or_province: get_value(queued_listing, %w(Address StateOrProvince)),
          country: get_value(queued_listing, %w(Address Country))
        )
      else
        return nil
      end
    end

    def self.currency_code queued_listing
      (result = get_value(queued_listing, %w(ListPrice currencyCode))) ? result : nil
    end
    
    def self.directions queued_listing
      (result = get_value(queued_listing, %w(Location Directions))) ? result : nil
    end

    def self.disclaimer queued_listing
      (result = get_value(queued_listing, %w(Disclaimer))) ? result : nil
    end

    def self.disclose_address queued_listing
      (result = get_value(queued_listing, %w(DiscloseAddress))) ? result.to_s.to_bool : nil
    end
    
    def self.elevation queued_listing
      (result = get_value(queued_listing, %w(Location Elevation))) ? result : nil
    end

    def self.expenses queued_listing, listing
      if (result = get_repeaters(queued_listing, %w(Expenses Expense)))
        result.map{|item| listing.expenses.find_or_initialize_by(
          expense_category: ExpenseCategory.find_by_name(item['ExpenseCategory']),
          currency_period: CurrencyPeriod.find_by_name(item['ExpenseValue']['currencyPeriod']),
          expense_value: unwrap_attribute(item['ExpenseValue'])
        )}
      end
    end

    def self.exterior_types queued_listing
      (result = get_enums(queued_listing, %w(DetailedCharacteristics ExteriorTypes ExteriorType))) ? result : nil
    end
    
    def self.floor_coverings queued_listing
      (result = get_enums(queued_listing, %w(DetailedCharacteristics FloorCoverings FloorCovering))) ? result : nil
    end
    
    def self.foreclosure_status queued_listing
      (result = get_value(queued_listing, %w(ForeclosureStatus))) ? ForeclosureStatus.find_by(name: result) : nil
    end
    
    def self.franchise queued_listing
      (result = get_value(queued_listing, %w(Franchise Name))) ? Franchise.find_or_initialize_by(name: result) : nil
    end

    def self.full_bathrooms queued_listing
      (result = get_value(queued_listing, %w(FullBathrooms))) ? result.to_i : nil
    end

    def self.geocode_options queued_listing
      (result = get_value(queued_listing, %w(Location GeocodeOptions))) ? result : nil
    end

    def self.half_bathrooms queued_listing
      (result = get_value(queued_listing, %w(HalfBathrooms))) ? result.to_i : nil
    end
    
    def self.heating_fuels queued_listing
      (result = get_enums(queued_listing, %w(DetailedCharacteristics HeatingFuels HeatingFuel))) ? result : nil
    end
    
    def self.heating_systems queued_listing
      (result = get_enums(queued_listing, %w(DetailedCharacteristics HeatingSystems HeatingSystem))) ? result : nil
    end
    
    def self.latitude queued_listing
      (result = get_value(queued_listing, %w(Location Latitude))) ? result.to_d : nil
    end

    def self.lead_routing_email queued_listing
      (result = get_value(queued_listing, %w(LeadRoutingEmail))) ? result : nil
    end

    def self.legal_description queued_listing
      (result = get_value(queued_listing, %w(DetailedCharacteristics LegalDescription))) ? result : nil
    end
    
    def self.list_price queued_listing
      (result = get_value(queued_listing, %w(ListPrice)).unwrap_attribute) ? result : nil
    end
    
    def self.list_price_low queued_listing
      (result = get_value(queued_listing, %w(ListPriceLow)).unwrap_attribute) ? result : nil
    end
    
    def self.listing_category queued_listing
      (result = get_value(queued_listing, %w(ListingCategory))) ? ListingCategory.find_by_name(result) : nil
    end

    def self.listing_date queued_listing
      (result = get_value(queued_listing, %w(ListingDate))) ? Chronic::parse(result).to_date : nil
    end
    
    def self.listing_description queued_listing
      (result = unwrap_attribute(get_value(queued_listing, %w(ListingDescription)))) ? result : nil
    end

    def self.listing_media queued_listing, listing, elements
      if (result = get_repeaters(queued_listing, elements))
        result.map do |item|
          media = listing.send(elements.last.tableize).find_or_initialize_by(
            media_url: item.drilldown('MediaURL'),
            media_modification_timestamp: (value = item.drilldown('MediaModificationTimestamp').is_a?(Hash) ? nil : value)
          )
          media.assign_attributes({
            media_order_number: item.drilldown('MediaOrderNumber'),
            media_caption: item.drilldown('MediaCaption'),
            media_description: item.drilldown('MediaDescription')
          })
          media
        end
      end
    end

    # TODO: Make ListingProvider and SourceProviderCategory Provider and ProviderCategory
    def self.listing_provider queued_listing
      (result = ListingProvider.find_or_initialize_by(
        name: get_value(queued_listing, %w(ProviderName)),
        url: get_value(queued_listing, %w(ProviderURL)),
        source_provider_category: SourceProviderCategory.find_by_name(get_value(queued_listing, %w(ProviderCategory)))
      )) ? result : nil
    end

    def self.listing_status queued_listing
      (result = get_value(queued_listing, %w(ListingStatus))) ? ListingStatus.find_by_name(result) : nil
    end
    
    def self.listing_title queued_listing
      (result = get_value(queued_listing, %w(ListingTitle))) ? result : nil
    end
    
    def self.listing_url queued_listing
      (result = get_value(queued_listing, %w(ListingURL))) ? result : nil
    end

    def self.living_area queued_listing
      (result = get_value(queued_listing, %w(LivingArea))) ? result.to_i : nil
    end
    
    def self.living_area_unit queued_listing
      (result = get_value(queued_listing, %w(LivingArea areaUnits))) ? result : nil
    end

    def self.longitude queued_listing
      (result = get_value(queued_listing, %w(Location Longitude))) ? result.to_d : nil
    end
    
    def self.lot_size queued_listing
      (result = get_value(queued_listing, %w(LotSize))) ? result : nil
    end

    def self.mls_number queued_listing
      (result = get_value(queued_listing, %w(MlsNumber))) ? result : nil
    end
    
    def self.modification_timestamp queued_listing
      # TODO: Change from string to datetime
      (result = get_value(queued_listing, %w(ModificationTimestamp))) ? result : nil
    end

    def self.multiple_listing_service queued_listing
      if (get_value(queued_listing, %w(MlsId)) || get_value(queued_listing, %w(MlsName)))
        MultipleListingService.find_or_initialize_by(
          mls_id: get_value(queued_listing, %w(MlsId)),
          mls_name: get_value(queued_listing, %w(MlsName))
        )
      end
    end

    def self.num_floors queued_listing
      (result = get_value(queued_listing, %w(DetailedCharacteristics NumFloors))) ? result.to_i : nil
    end
    
    def self.num_parking_spaces queued_listing
      (result = get_value(queued_listing, %w(DetailedCharacteristics NumParkingSpaces))) ? result.to_i : nil
    end
    
    def self.office queued_listing
      if (result = get_value(queued_listing, %w(Offices Office)))
        office = Office.find_or_initialize_by(
          office_identifier: result.drilldown('OfficeId'),
          name: result.drilldown('Name')
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

    def self.one_quarter_bathrooms queued_listing
      (result = get_value(queued_listing, %w(OneQuarterBathrooms))) ? result.to_i : nil
    end

    # TODO: Figure out how to provide time zone for StartTime and EndTime 
    def self.open_houses queued_listing, listing
      if (result = get_repeaters(queued_listing, %w(OpenHouses OpenHouse)))
        result.map{|open_house| listing.open_houses.find_or_initialize_by(
          showing_date: Chronic::parse(open_house['Date']).to_date,
          start_time: open_house['StartTime'],
          end_time: open_house['EndTime'],
          description: open_house['Description']
        )}
      end
    end

    def self.parcel_id queued_listing
      (result = get_value(queued_listing, %w(Location ParcelId))) ? result : nil
    end

    # TODO: Change participant_identifier to participant_id
    def self.participants queued_listing
      if (result = get_repeaters(queued_listing, %w(ListingParticipants Participant)))
        result.map do |item| 
          participant = Participant.find_or_initialize_by(
            first_name: item['FirstName'],
            last_name: item['LastName'],
            email: item['Email']
          )
          participant.assign_attributes({
            participant_key: item['ParticipantKey'],
            participant_identifier: item['ParticipantId'],
            participant_role: ParticipantRole.find_by(name: item['Role']),
            primary_contact_phone: item['PrimaryContactPhone'],
            office_phone: item['OfficePhone'],
            fax: item['Fax'],
            website_url: item['WebsiteURL']
          })
          participant
        end
      end
    end

    def self.permit_address_on_internet queued_listing
      (result = get_value(queued_listing, %w(MarketingInformation PermitAddressOnInternet))) ? result.to_s.to_bool : nil
    end
    
    def self.photos queued_listing, listing
      (result = listing_media(queued_listing, listing, %w(Photos Photo))) ? result : nil
    end

    def self.property_sub_type queued_listing
      (result = unwrap_attribute(get_value(queued_listing, %w(PropertySubType)))) ? PropertySubType.find_by_name(result) : nil
    end
    
    def self.property_sub_type_description queued_listing
      (result = get_value(queued_listing, %w(PropertySubType otherDescription))) ? result : nil
    end
    
    def self.property_type queued_listing
      (result = unwrap_attribute(get_value(queued_listing, %w(PropertyType)))) ? PropertyType.find_by_name(result) : nil
    end

    def self.property_type_description queued_listing
      (result = get_value(queued_listing, %w(PropertyType otherDescription))) ? result : nil
    end
    
    def self.roof_types queued_listing
      (result = get_enums(queued_listing, %w(DetailedCharacteristics RoofTypes RoofType))) ? result : nil
    end
    
    def self.room_count queued_listing
      (result = get_value(queued_listing, %w(DetailedCharacteristics RoomCount))) ? result.to_i : nil
    end
    
    def self.rooms queued_listing, listing
      if (result = get_value(queued_listing, %w(DetailedCharacteristics Rooms Room)))
        result.map{|room_category| Room.new(listing: listing, room_category: RoomCategory.find_by(name: room_category))}
      end
    end
    
    def self.taxes queued_listing
      if (result = get_repeaters(queued_listing, %w(Taxes Tax)))
        result.map{|item| Tax.find_or_initialize_by(
          year: item['Year'],
          amount: item['Amount'],
          description: item['TaxDescription']
        )}
      end
    end

    def self.three_quarter_bathrooms queued_listing
      (result = get_value(queued_listing, %w(ThreeQuarterBathrooms))) ? result.to_i : nil
    end

    def self.videos queued_listing, listing
      (result = listing_media(queued_listing, listing, %w(Videos Video))) ? result : nil
    end

    def self.view_types queued_listing
      (result = get_enums(queued_listing, %w(DetailedCharacteristics ViewTypes ViewType))) ? result : nil
    end
    
    def self.virtual_tours queued_listing, listing
      (result = listing_media(queued_listing, listing, %w(VirtualTours VirtualTour))) ? result : nil
    end

    def self.vow_address_display queued_listing
      (result = unwrap_attribute(get_value(queued_listing, %w(MarketingInformation VOWAddressDisplay)))) ? result.to_s.to_bool : nil
    end

    def self.vow_automated_valuation_display queued_listing
      (result = unwrap_attribute(get_value(queued_listing, %w(MarketingInformation VOWAutomatedValuationDisplay)))) ? result.to_s.to_bool : nil
    end

    def self.vow_consumer_comment queued_listing
      (result = unwrap_attribute(get_value(queued_listing, %w(MarketingInformation VOWConsumerComment)))) ? result.to_s.to_bool : nil
    end
    
    def self.year_built queued_listing
      (result = get_value(queued_listing, %w(YearBuilt))) ? result.to_i : nil
    end

    def self.year_updated queued_listing
      (result = get_value(queued_listing, %w(DetailedCharacteristics YearUpdated))) ? result.to_i : nil
    end
    
    # Utilities
    
    def self.unique_identifier queued_listing
      (result = get_value(queued_listing, queued_listing.import.unique_identifier.split(' ')))
    end
    
    def self.unwrap_attribute value
      value.is_a?(Hash) ? (value['__content__'] ? value['__content__'] : value) : value
    end
    
    def self.get_repeaters queued_listing, elements
      if (value = get_value(queued_listing, elements[0..-2]))
        (result = value.drilldown(elements.last)) ? (result.is_a?(Array) ? result : [result]) : nil
      else
        return []
      end
    end
    
    # TODO: Should be find_by_name not find_or_create_by_name. Remove after before_save validation.
    def self.get_enums queued_listing, elements
      if (result = get_repeaters(queued_listing, elements))
        result.map{|name| elements.last.constantize.find_or_create_by(name: name)}
      else
        nil
      end
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

    def self.create_or_update_listing queued_listing
      listing = queued_listing.import.listings.find_or_initialize_by(
        listing_key: unique_identifier(queued_listing)
      )
      if (listing.modification_timestamp != modification_timestamp(queued_listing))
        listing.assign_attributes({
          address: address(queued_listing, listing),
          alternate_prices: alternate_prices(queued_listing, listing),        
          appliances: appliances(queued_listing),
          architecture_style: architecture_style(queued_listing),
          architecture_style_description: architecture_style_description(queued_listing),
          bathrooms: bathrooms(queued_listing),
          bedrooms: bedrooms(queued_listing),
          brokerage: brokerage(queued_listing),
          building_unit_count: building_unit_count(queued_listing),
          condo_floor_num: condo_floor_num(queued_listing),
          cooling_systems: cooling_systems(queued_listing),
          county: county(queued_listing),
          currency_code: currency_code(queued_listing),
          directions: directions(queued_listing),
          disclaimer: disclaimer(queued_listing),
          disclose_address: disclose_address(queued_listing),
          elevation: elevation(queued_listing),
          expenses: expenses(queued_listing, listing),
          exterior_types: exterior_types(queued_listing),
          floor_coverings: floor_coverings(queued_listing),
          foreclosure_status: foreclosure_status(queued_listing),
          franchise: franchise(queued_listing),
          full_bathrooms: full_bathrooms(queued_listing),
          geocode_options: geocode_options(queued_listing),
          half_bathrooms: half_bathrooms(queued_listing),
          heating_fuels: heating_fuels(queued_listing),
          heating_systems: heating_systems(queued_listing),
          import: queued_listing.import,
          latitude: latitude(queued_listing),
          lead_routing_email: lead_routing_email(queued_listing),
          legal_description: legal_description(queued_listing),
          list_price: list_price(queued_listing),
          list_price_low: list_price_low(queued_listing),
          listing_category: listing_category(queued_listing),
          listing_date: listing_date(queued_listing),
          listing_description: listing_description(queued_listing),
          listing_provider: listing_provider(queued_listing),
          listing_status: listing_status(queued_listing),
          listing_title: listing_title(queued_listing),
          listing_url: listing_url(queued_listing),
          living_area: living_area(queued_listing),
          living_area_unit: living_area_unit(queued_listing),
          longitude: longitude(queued_listing),
          lot_size: lot_size(queued_listing),
          mls_number: mls_number(queued_listing),
          multiple_listing_service: multiple_listing_service(queued_listing),
          modification_timestamp: modification_timestamp(queued_listing),
          num_floors: num_floors(queued_listing),
          num_parking_spaces: num_parking_spaces(queued_listing),
          office: office(queued_listing),
          one_quarter_bathrooms: one_quarter_bathrooms(queued_listing),
          open_houses: open_houses(queued_listing, listing),
          parcel_info: parcel_id(queued_listing),
          participants: participants(queued_listing),
          permit_address_on_internet: permit_address_on_internet(queued_listing),
          photos: photos(queued_listing, listing),
          property_sub_type: property_sub_type(queued_listing), 
          property_sub_type_description: property_sub_type_description(queued_listing),
          property_type: property_type(queued_listing),
          property_type_description: property_type_description(queued_listing),
          roof_types: roof_types(queued_listing),
          room_count: room_count(queued_listing),
          rooms: rooms(queued_listing, listing),
  # TODO: subdivision: subdivision(queued_listing),
          taxes: taxes(queued_listing),
          three_quarter_bathrooms: three_quarter_bathrooms(queued_listing),
          videos: videos(queued_listing, listing),
          view_types: view_types(queued_listing),
          virtual_tours: virtual_tours(queued_listing, listing),
          vow_address_display: vow_address_display(queued_listing),
          vow_automated_valuation_display: vow_automated_valuation_display(queued_listing),
          vow_consumer_comment: vow_consumer_comment(queued_listing),
          year_built: year_built(queued_listing),
          year_updated: year_updated(queued_listing)
        })
      end
      listing.save
    end
  end
end