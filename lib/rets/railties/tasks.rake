namespace :rets do

	task :load_enumerals => [:environment] do
		require "csv"
		csv_text = File.read("#{Rails.root}/db/enumerals.csv")
		csv = CSV.parse(csv_text, :headers => true)
		csv.each do |row|
        	row = row.to_hash.with_indifferent_access
			Enumeral.create!(row.to_hash.symbolize_keys)
            puts row.inspect
        end
        puts ""
    end

	task :import_example_xml => [:environment] do
	    require 'nokogiri'

	    @doc = Nokogiri::XML(f = File.open("#{Rails.root}/db/example.xml"))

    @doc.css('Listing').each do |p|
      @listing = Listing.new(
        :list_price => p.children.at_css('ListPrice').try(:inner_text), 
        :list_price_low => p.children.at_css('ListPriceLow').try(:inner_text),
        :listing_url => p.children.at_css('ListingURL').try(:inner_text),
        :listing_provider => ListingProvider.find_or_initialize_by(
          :name => p.children.at_css('ProviderName').try(:inner_text), 
          :url => p.children.at_css('ProviderURL').try(:inner_text), 
          :source_provider_category => SourceProviderCategory.find_by_name(p.children.at_css('ProviderCategory').try(:inner_text))
        ),
        :lead_routing_email => p.children.at_css('LeadRoutingEmail').try(:inner_text),
        :bedrooms => p.children.at_css('Bedrooms').try(:inner_text),
        :bathrooms => p.children.at_css('Bathrooms').try(:inner_text),
        :property_type => PropertyType.find_by_name(p.children.at_css('PropertyType').try(:inner_text)), 
        :property_sub_type => PropertySubType.find_by_name(p.children.at_css('PropertySubType').try(:inner_text)), 
        :listing_key => p.children.at_css('ListingKey').try(:inner_text),
        :listing_category => ListingCategory.find_by_name(p.children.at_css('ListingCategory').try(:inner_text)), 
        :listing_status => ListingStatus.find_by_name(p.children.at_css('ListingStatus').try(:inner_text)),
        :permit_address_on_internet => p.at_css("commons|PermitAddressOnInternet").try(:inner_text),
        :vow_address_display => p.at_css("commons|VOWAddressDisplay").try(:inner_text),
        :vow_automated_valuation_display => p.at_css("commons|VOWAutomatedValuationDisplay").try(:inner_text),
        :vow_consumer_comment => p.at_css("commons|VOWConsumerComment").try(:inner_text),
        :disclose_address => p.children.at_css('DiscloseAddress').try(:inner_text),
        :short_sale => p.children.at_css('ShortSale').try(:inner_text),
        :listing_description => p.children.at_css('ListingDescription').try(:inner_text),
        :listing_service => ListingService.find_or_initialize_by(
          :identifier => p.children.at_css('MlsId').try(:inner_text),
          :name => p.children.at_css('MlsName').try(:inner_text)
        ),
        :listing_service_identifier => p.children.at_css('MlsNumber').try(:inner_text),
        :living_area => p.children.at_css('LivingArea').try(:inner_text),
        :lot_size => p.children.at_css('LotSize').try(:inner_text),
        :year_built => p.children.at_css('YearBuilt').try(:inner_text),
        :year_updated => p.children.at_css('YearUpdated').try(:inner_text), 
        :listing_date => p.children.at_css('ListingDate').try(:inner_text),
        :listing_title => p.children.at_css('ListingTitle').try(:inner_text),
        :full_bathrooms => p.children.at_css('FullBathrooms').try(:inner_text),
        :three_quarter_bathrooms => p.children.at_css('ThreeQuarterBathrooms').try(:inner_text),
        :half_bathrooms => p.children.at_css('HalfBathrooms').try(:inner_text),
        :one_quarter_bathrooms => p.children.at_css('OneQuarterBathrooms').try(:inner_text),
        :latitude => p.children.at_css('Latitude').try(:inner_text),
        :longitude => p.children.at_css('Longitude').try(:inner_text),
        :elevation => p.children.at_css('Elevation').try(:inner_text),
        :directions => p.children.at_css('Directions').try(:inner_text),
        :geocode_options => p.children.at_css('GeocodeOptions').try(:inner_text),
        :parcel_info => p.children.at_css('ParcelId').try(:inner_text),
        :building_unit_count => p.children.at_css('BuildingUnitCount').try(:inner_text),
        :condo_floor_num => p.children.at_css('CondoFloorNum').try(:inner_text),
        :legal_description => p.children.at_css('LegalDescription').try(:inner_text),
        :num_floors => p.children.at_css('NumFloors').try(:inner_text), 
        :num_parking_spaces => p.children.at_css('NumParkingSpaces').try(:inner_text), 
        :room_count => p.children.at_css('RoomCount').try(:inner_text), 
        :modification_timestamp => p.children.at_css('ModificationTimestamp').try(:inner_text)
      )
      p.css('/Address').each do |address|
        @listing.addresses << Address.new(
          :preference_order => address.at_css('commons|preference-order').try(:inner_text),
          :address_preference_order => address.at_css('commons|address-preference-order').try(:inner_text),
          :full_street_address => address.at_css('commons|FullStreetAddress').try(:inner_text),
          :unit_number => address.at_css('commons|UnitNumber').try(:inner_text),
          :city => address.at_css('commons|City').try(:inner_text),
          :state_or_province => address.at_css('commons|StateOrProvince').try(:inner_text),
          :postal_code => address.at_css('commons|PostalCode').try(:inner_text),
          :country => address.at_css('commons|Country').try(:inner_text)
        )
      end
      p.css('Location County').each do |county|
        @listing.counties << County.find_or_initialize_by(
          :name => county.try(:inner_text),
          :state_or_province => @listing.addresses.first.state_or_province,
          :country => @listing.addresses.first.country
        )
      end
      p.css('Location Community').each do |community|
        @community = @listing.communities.find_or_initialize_by(
          :name => community.at_css('commons|Subdivision').try(:inner_text),
          :city => @listing.addresses.first.city,
          :state_or_province => @listing.addresses.first.state_or_province,
          :country => @listing.addresses.first.country
        )
        p.css('commons|Schools commons|School').each do |school|
          @community.schools << School.find_or_initialize_by(
            :name => school.at_css('commons|Name').try(:inner_text),
            :school_category => SchoolCategory.find_by(:name => school.at_css('commons|SchoolCategory').try(:inner_text)),
            :district => school.at_css('commons|District').try(:inner_text)
# county, state, country, find_or_create_by
          )
        end
      end
      p.css('ListingParticipants Participant').each do |participant|
        @listing.listing_participants << @listing_participant = ListingParticipant.find_or_initialize_by(
# find_or_create_by
          :participant_key => participant.at_css('ParticipantKey').try(:inner_text),
          :participant_identifier => participant.at_css('ParticipantId').try(:inner_text),
          :first_name => participant.at_css('FirstName').try(:inner_text),
          :last_name => participant.at_css('LastName').try(:inner_text),
          :role => participant.at_css('Role').try(:inner_text), 
          :primary_contact_phone => participant.at_css('PrimaryContactPhone').try(:inner_text),
          :office_phone => participant.at_css('OfficePhone').try(:inner_text),
          :email => participant.at_css('Email').try(:inner_text),
          :fax => participant.at_css('Fax').try(:inner_text),
          :website_url => participant.at_css('WebsiteURL').try(:inner_text)
        )
        participant.css('Licenses License').each do |license|
#puts license.inspect
#          @listing_participant.listing_participant_licenses << ListingParticipantLicense.find_or_initialize_by(
#            :license_category => LicenseCategory.find_by(:name => license.at_css('LicenseCategory').try(:inner_text)),
#            :license_number => license.at_css('LicenseNumber').try(:inner_text),
#            :jurisdiction => license.at_css('Jurisdiction').try(:inner_text),
#            :state_or_province => license.at_css('StateOrProvince').try(:inner_text)
#          )
        end
      end
      %w[brokerage builder franchise].each do |b|
        p.css(b.classify).each do |business|
          @b = @listing.send(b.pluralize).find_or_initialize_by(
            :type => b.classify,
            :name => business.at_css('Name').try(:inner_text),
            :phone => business.at_css('Phone').try(:inner_text),  
            :fax => business.at_css('Fax').try(:inner_text),
            :email => business.at_css('Email').try(:inner_text),
            :website_url => business.at_css('WebsiteURL').try(:inner_text),
            :logo_url => business.at_css('LogoURL').try(:inner_text)
          )
          business.css('Address').each do |address|
            @b.addresses << Address.find_or_initialize_by(
              :preference_order => address.at_css('commons|preference-order').try(:inner_text),
              :address_preference_order => address.at_css('commons|address-preference-order').try(:inner_text),
              :full_street_address => address.at_css('commons|FullStreetAddress').try(:inner_text),
              :unit_number => address.at_css('commons|UnitNumber').try(:inner_text),
              :city => address.at_css('commons|City').try(:inner_text),
              :state_or_province => address.at_css('commons|StateOrProvince').try(:inner_text),
              :postal_code => address.at_css('commons|PostalCode').try(:inner_text),
              :country => address.at_css('commons|Country').try(:inner_text)
            )
          end
        end
      end
      p.css('Offices Office').each do |office|
        @listing.offices <<  @office = Office.find_or_initialize_by(
          :office_key => office.at_css('OfficeKey').try(:inner_text),
          :office_identifier => office.at_css('OfficeId').try(:inner_text),
          :office_code_identifier => office.at_css('OfficeCode OfficeCodeId').try(:inner_text),
          :main_office_identifier => office.at_css('MainOfficeId').try(:inner_text),
          :name => office.at_css('Name').try(:inner_text),
          :corporate_name => office.at_css('CorporateName').try(:inner_text),
          :broker_identifier => office.at_css('BrokerId').try(:inner_text),
          :phone_number => office.at_css('PhoneNumber').try(:inner_text),
          :website => office.at_css('Website').try(:inner_text),
        )
        office.css('Address').each do |address|
          @office.addresses.find_or_initialize_by(
            :preference_order => address.at_css('commons|preference-order').try(:inner_text),
            :address_preference_order => address.at_css('commons|address-preference-order').try(:inner_text),
            :full_street_address => address.at_css('commons|FullStreetAddress').try(:inner_text),
            :unit_number => address.at_css('commons|UnitNumber').try(:inner_text),
            :city => address.at_css('commons|City').try(:inner_text),
            :state_or_province => address.at_css('commons|StateOrProvince').try(:inner_text),
            :postal_code => address.at_css('commons|PostalCode').try(:inner_text),
            :country => address.at_css('commons|Country').try(:inner_text)
          )
        end
      end
      p.css('Neighborhoods Neighborhood').each do |neighborhood|
        @listing.neighborhoods << Neighborhood.find_or_initialize_by(
          :name => neighborhood.at_css('Name').try(:inner_text), 
          :description => neighborhood.at_css('Description').try(:inner_text),
          :city => @listing.addresses.first.city,
          :state_or_province => @listing.addresses.first.state_or_province,
          :country => @listing.addresses.first.country
        )
      end
      p.children.css('Photos Photo').each do |photo|
        @listing.listing_photos << ListingPhoto.new(
          :media_url => photo.at_css('MediaURL').try(:inner_text), 
          :media_modification_timestamp => photo.at_css('MediaModificationTimestamp').try(:inner_text),
          :media_caption => photo.at_css('MediaCaption').try(:inner_text),
          :media_description => photo.at_css('MediaDescription').try(:inner_text)
        )
      end
      p.children.css('OpenHouses OpenHouse').each do |oh|
        @listing.open_houses << OpenHouse.new(
          :showing_date => oh.at_css('Date').try(:inner_text), 
          :start_time => oh.at_css('StartTime').try(:inner_text),
          :end_time => oh.at_css('EndTime').try(:inner_text),
          :description => oh.at_css('Description').try(:inner_text)
        )
      end
      p.children.css('Taxes Tax').each do |tax|
        @listing.taxes << Tax.new(
          :year => tax.at_css('Year').try(:inner_text), 
          :amount => tax.at_css('Amount').try(:inner_text),
          :description => tax.at_css('TaxDescription').try(:inner_text)
        )
      end
      p.children.css('Expenses Expense').each do |expense|
#        @listing.expenses << Expense.new(
#          :expense_category => ExpenseCategory.find_by(:name => expense.at_css('commons|ExpenseCategory').try(:inner_text)),
#          :currency_period => CurrencyPeriod.find_by(:name => expense.at_css('commons|ExpenseValue').attributes['currencyPeriod'].try(:value)),
#          :expense_value => expense.at_css('commons|ExpenseValue').try(:inner_text)
#        )
      end
      @enumerals = Enumeral.all
      p.css('ForeclosureStatus').each do |foreclosure_status|
        @foreclosure_status = ForeclosureStatus.find_or_create_by(:name => foreclosure_status.try(:inner_text))
        @listing.foreclosure_statuses << @foreclosure_status unless @listing.foreclosure_statuses.map(&:id).include?(@foreclosure_status.id)
      end
      p.children.css('Appliances Appliance').each do |appliance|
        @appliance = Appliance.find_or_create_by(:name => appliance.try(:inner_text))
        @listing.appliances << @appliance unless @listing.appliances.map(&:id).include?(@appliance.id)
      end
      p.children.css('CoolingSystems CoolingSystem').each do |cooling_system|
        @cooling_system = CoolingSystem.find_or_create_by(:name => cooling_system.try(:inner_text))
        @listing.cooling_systems << @cooling_system unless @listing.cooling_systems.map(&:id).include?(@cooling_system.id)
      end
      p.children.css('ExteriorTypes ExteriorType').each do |exterior_type|
        @exterior_type = ExteriorType.find_or_create_by(:name => exterior_type.try(:inner_text))
        @listing.exterior_types << @exterior_type unless @listing.exterior_types.map(&:id).include?(@exterior_type.id)
      end
      p.children.css('FloorCoverings FloorCovering').each do |flooring_material|
        @flooring_material = FlooringMaterial.find_or_create_by(:name => flooring_material.try(:inner_text))
        @listing.flooring_materials << @flooring_material unless @listing.flooring_materials.map(&:id).include?(@flooring_material.id)
      end
      p.children.css('HeatingFuels HeatingFuel').each do |heating_fuel|
        @heating_fuel = HeatingFuel.find_or_create_by(:name => heating_fuel.try(:inner_text))
        @listing.heating_fuels << @heating_fuel unless @listing.heating_fuels.map(&:id).include?(@heating_fuel.id)
      end
      p.children.css('HeatingSystems HeatingSystem').each do |heating_system|
        @heating_system = HeatingSystem.find_or_create_by(:name => heating_system.try(:inner_text))
        @listing.heating_systems << @heating_system unless @listing.heating_systems.map(&:id).include?(@heating_system.id)
      end
      p.css('RoofTypes RoofType').each do |roof_material|
        @roof_material = RoofMaterial.find_or_create_by(:name => roof_material.try(:inner_text))
        @listing.roof_materials << @roof_material unless @listing.roof_materials.map(&:id).include?(@roof_material.id)
      end
      p.css('ViewTypes ViewType').each do |view_type|
        @view_type = View.find_or_create_by(:name => view_type.try(:inner_text))
        @listing.views << @view_type unless @listing.views.map(&:id).include?(@view_type.id)
      end
      p.css('Rooms Room').each do |room|
        @listing.rooms << Room.create(:room_category => RoomCategory.find_or_create_by(:name => room.try(:inner_text)))
      end
      %w[HasAttic HasBarbecueArea HasBasement HasCeilingFan HasDeck HasDisabledAccess HasDock HasDoorman HasDoublePaneWindows HasElevator HasFireplace HasGarden HasGatedEntry HasGreenhouse HasHotTubSpa HasJettedBathTub HasLawn HasMotherInLaw HasPatio HasPond HasPool HasPorch HasRVParking HasSauna HasSecuritySystem HasSkylight HasSportsCourt HasSprinklerSystem HasVaultedCeiling HasWetBar Intercom IsCableReady IsNewConstruction IsWaterfront IsWired].each do |feature|
        @listing.home_features << @enumerals.detect{ |e| (e.name == feature && e.type == 'HomeFeature')} if p.at_css(feature).try(:inner_text).try(:downcase).eql? "true"
      end

     if @listing.save!
       puts @listing.listing_title
     else
       puts "FAILED"
     end
    end
  end

	desc "Populate database with seed data."
	task :seed => [:import_example_xml] do
	end
  
  
end
