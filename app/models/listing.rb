class Listing < ActiveRecord::Base
  require 'nokogiri'

  before_destroy :destroy_addresses
  
  belongs_to :listing_provider
  belongs_to :property_type
  belongs_to :property_sub_type
  belongs_to :listing_category
  belongs_to :listing_status
  belongs_to :mls
  belongs_to :zoning_type
  belongs_to :architecture_style
  belongs_to :county
  belongs_to :community
  belongs_to :foreclosure_status

  has_many :expenses, :dependent => :destroy
  has_many :open_houses, :dependent => :destroy
  has_many :rooms, :dependent => :destroy
  has_many :taxes, :dependent => :destroy
  has_many :photos, :dependent => :destroy
  has_many :videos, :dependent => :destroy
  has_many :virtual_tours, :dependent => :destroy
  
  has_many :people, :through => :participants

  accepts_nested_attributes_for :expenses, allow_destroy: true
  accepts_nested_attributes_for :open_houses, allow_destroy: true
  accepts_nested_attributes_for :rooms, allow_destroy: true
  accepts_nested_attributes_for :taxes, allow_destroy: true
  
  has_and_belongs_to_many :addresses
  has_and_belongs_to_many :participants
  has_many :listing_offices
  has_many :offices, :through => :listing_offices

  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :participants, allow_destroy: true

  has_and_belongs_to_many :brokerages, association_foreign_key: "business_id"
  has_and_belongs_to_many :builders, association_foreign_key: "business_id"
  has_and_belongs_to_many :franchises, association_foreign_key: "business_id"

  has_and_belongs_to_many :neighborhoods, association_foreign_key: "place_id"

  has_and_belongs_to_many :appliances, association_foreign_key: "enumeral_id"
  has_and_belongs_to_many :cooling_systems, association_foreign_key: "enumeral_id"
  has_and_belongs_to_many :exterior_types, association_foreign_key: "enumeral_id"
  has_and_belongs_to_many :floor_coverings, association_foreign_key: "enumeral_id"
  has_and_belongs_to_many :heating_fuels, association_foreign_key: "enumeral_id"
  has_and_belongs_to_many :heating_systems, association_foreign_key: "enumeral_id"
  has_and_belongs_to_many :home_features, association_foreign_key: "enumeral_id"
  has_and_belongs_to_many :roof_types, association_foreign_key: "enumeral_id"
  has_and_belongs_to_many :parking, association_foreign_key: "enumeral_id"
  has_and_belongs_to_many :view_types, association_foreign_key: "enumeral_id"
  
  accepts_nested_attributes_for :appliances
  accepts_nested_attributes_for :cooling_systems
  accepts_nested_attributes_for :exterior_types
  accepts_nested_attributes_for :floor_coverings
  accepts_nested_attributes_for :heating_fuels
  accepts_nested_attributes_for :heating_systems
  accepts_nested_attributes_for :home_features
  accepts_nested_attributes_for :roof_types
  accepts_nested_attributes_for :parking
  accepts_nested_attributes_for :view_types
  
  validates_presence_of :property_type
  validates_presence_of :property_sub_type
  validates_presence_of :listing_category
  
  def address
    self.addresses.first
  end
  
  def brokerage
    self.brokerages.first
  end
  
  def listing_office
    self.listing_offices.first.office
  end
  
  def destroy_addresses
    self.addresses.each do |address|
      address.destroy
    end
  end
    
  def self.import_or_update_item(p)

    # Listing

    @listing = Listing.find_or_initialize_by(:listing_key => p.at_css('ListingKey').try(:inner_text))
    @listing.assign_attributes({
      :list_price => p.at_css('ListPrice').try(:inner_text), 
      :list_price_low => p.at_css('ListPriceLow').try(:inner_text),
      :listing_url => p.at_css('ListingURL').try(:inner_text),
      :lead_routing_email => p.at_css('LeadRoutingEmail').try(:inner_text),
      :bedrooms => p.at_css('Bedrooms').try(:inner_text),
      :bathrooms => p.at_css('Bathrooms').try(:inner_text),
      :property_type => PropertyType.find_by_name(p.at_css('PropertyType').try(:inner_text)), 
      :property_sub_type => PropertySubType.find_by_name(p.at_css('PropertySubType').try(:inner_text)), 
      :listing_key => p.at_css('ListingKey').try(:inner_text),
      :listing_category => ListingCategory.find_by_name(p.at_css('ListingCategory').try(:inner_text)), 
      :listing_status => ListingStatus.find_by_name(p.at_css('ListingStatus').try(:inner_text)),
      :listing_provider => ListingProvider.find_or_initialize_by(
        :name => p.at_css('ProviderName').try(:inner_text), 
        :url => p.at_css('ProviderURL').try(:inner_text), 
        :source_provider_category => SourceProviderCategory.find_by_name(p.at_css('ProviderCategory').try(:inner_text))
      ),
      :listing_service => ListingService.find_or_initialize_by(
        :identifier => p.at_css('MlsId').try(:inner_text),
        :name => p.at_css('MlsName').try(:inner_text)
      ),
      :permit_address_on_internet => p.at_css("PermitAddressOnInternet").try(:inner_text),
      :vow_address_display => p.at_css("VOWAddressDisplay").try(:inner_text),
      :vow_automated_valuation_display => p.at_css("VOWAutomatedValuationDisplay").try(:inner_text),
      :vow_consumer_comment => p.at_css("VOWConsumerComment").try(:inner_text),
      :disclose_address => p.at_css('DiscloseAddress').try(:inner_text),
      :short_sale => p.at_css('ShortSale').try(:inner_text),
      :listing_description => p.at_css('ListingDescription').try(:inner_text),
      :listing_service_identifier => p.at_css('MlsNumber').try(:inner_text),
      :living_area => p.at_css('LivingArea').try(:inner_text),
      :lot_size => p.at_css('LotSize').try(:inner_text),
      :year_built => p.at_css('YearBuilt').try(:inner_text),
      :year_updated => p.at_css('YearUpdated').try(:inner_text), 
      :listing_date => p.at_css('ListingDate').try(:inner_text),
      :listing_title => p.at_css('ListingTitle').try(:inner_text),
      :full_bathrooms => p.at_css('FullBathrooms').try(:inner_text),
      :three_quarter_bathrooms => p.at_css('ThreeQuarterBathrooms').try(:inner_text),
      :half_bathrooms => p.at_css('HalfBathrooms').try(:inner_text),
      :one_quarter_bathrooms => p.at_css('OneQuarterBathrooms').try(:inner_text),
      :latitude => p.at_css('Latitude').try(:inner_text),
      :longitude => p.at_css('Longitude').try(:inner_text),
      :elevation => p.at_css('Elevation').try(:inner_text),
      :directions => p.at_css('Directions').try(:inner_text),
      :geocode_options => p.at_css('GeocodeOptions').try(:inner_text),
      :parcel_info => p.at_css('ParcelId').try(:inner_text),
      :building_unit_count => p.at_css('BuildingUnitCount').try(:inner_text),
      :condo_floor_num => p.at_css('CondoFloorNum').try(:inner_text),
      :legal_description => p.at_css('LegalDescription').try(:inner_text),
      :num_floors => p.at_css('NumFloors').try(:inner_text), 
      :num_parking_spaces => p.at_css('NumParkingSpaces').try(:inner_text), 
      :room_count => p.at_css('RoomCount').try(:inner_text), 
      :modification_timestamp => p.at_css('ModificationTimestamp').try(:inner_text)
    })

    # Appliances, Cooling Systems, Exterior Types, Heating Fuels, Heating System, Floor Coverings, Roof Types, Views

    %w[appliance cooling_system exterior_type heating_fuel heating_system floor_covering roof_type view_type].each do |feature|
      p.css("#{feature.classify.pluralize} #{feature.classify}").each do |item|
        @item = feature.classify.constantize.find_or_create_by(:name => item.try(:inner_text))
        @listing.send(feature.pluralize) << @item unless @listing.send(feature.pluralize).include? @item
      end
    end

    # Home Features

    @enumerals = Enumeral.all
    %w[HasAttic HasBarbecueArea HasBasement HasCeilingFan HasDeck HasDisabledAccess HasDock HasDoorman HasDoublePaneWindows HasElevator HasFireplace HasGarden HasGatedEntry HasGreenhouse HasHotTubSpa HasJettedBathTub HasLawn HasMotherInLaw HasPatio HasPond HasPool HasPorch HasRVParking HasSauna HasSecuritySystem HasSkylight HasSportsCourt HasSprinklerSystem HasVaultedCeiling HasWetBar Intercom IsCableReady IsNewConstruction IsWaterfront IsWired].each do |feature|
      @home_feature = @enumerals.detect{ |e| (e.name == feature && e.type == 'HomeFeature')}
      @listing.home_features << @home_feature if p.at_css(feature).try(:inner_text).try(:downcase).eql? "true" unless @listing.home_features.include? @home_feature
    end

    # Photos, Videos, Virtual Tours

    %w[photo video virtual_tour].each do |media_type|
      incoming_media_urls = Array.new
      p.css("#{media_type.classify.pluralize} #{media_type.classify}").each do |item|
        incoming_media_urls << item.at_css('MediaURL')
        @item = @listing.send(media_type.pluralize).find_or_initialize_by(:media_url => item.at_css('MediaURL').try(:inner_text))
        @item.assign_attributes({   
          :media_modification_timestamp => item.at_css('MediaModificationTimestamp').try(:inner_text),
          :media_caption => item.at_css('MediaCaption').try(:inner_text),
          :media_description => item.at_css('MediaDescription').try(:inner_text)
        })
        @listing.send(media_type.pluralize) << @item unless @listing.send(media_type.pluralize).include? @item
      end
      existing_media_urls = @listing.send(media_type.pluralize).select(:media_url).pluck(:media_url)
      (existing_media_urls - incoming_media_urls).each do |orphaned_media_url|
        @item = @listing.send(media_type.pluralize).find_by(:media_url => orphaned_media_url)
        @item.destroy
      end
    end
    
    # Listing Addresses

    @listing.addresses.each{|address| address.destroy }
    address = p.at_css('Address')
    @address = @listing.addresses.find_or_initialize_by(
      :preference_order => address.at_css('preference-order').try(:inner_text),
      :address_preference_order => address.at_css('address-preference-order').try(:inner_text),
      :full_street_address => address.at_css('FullStreetAddress').try(:inner_text),
      :unit_number => address.at_css('UnitNumber').try(:inner_text),
      :city => address.at_css('City').try(:inner_text),
      :state_or_province => address.at_css('StateOrProvince').try(:inner_text),
      :postal_code => address.at_css('PostalCode').try(:inner_text),
      :country => address.at_css('Country').try(:inner_text)
    )
    @listing.addresses << @address unless @listing.addresses.include? @address

    # County

    p.css('Location County').each do |county|
      @listing.county = County.find_or_initialize_by(
        :name => county.try(:inner_text),
        :state_or_province => @listing.addresses.first.state_or_province,
        :country => @listing.addresses.first.country
      )
    end

    # Communities and Schools

    p.css('Location Community').each do |community|
      @community = Community.find_or_create_by(
        :name => community.at_css('Subdivision').try(:inner_text),
        :city => @listing.addresses.first.city,
        :state_or_province => @listing.addresses.first.state_or_province,
        :country => @listing.addresses.first.country
      )
      p.css('Schools School').each do |school|
        @school = @community.schools.find_or_create_by(
          :name => school.at_css('Name').try(:inner_text),
          :school_category => SchoolCategory.find_by(:name => school.at_css('SchoolCategory').try(:inner_text)),
          :district => school.at_css('District').try(:inner_text)
        )
        @community.schools << @school unless (@community.schools.include? @school)
      end
      @listing.community = @community
    end

    # Participants

#    @listing.participants.each{|lp| lp.delete }
    p.css('ListingParticipants Participant').each do |participant|
      @participant = Participant.find_or_initialize_by(:participant_key => participant.at_css('ParticipantKey').try(:inner_text))
      @participant.assign_attributes({
        :participant_identifier => participant.at_css('ParticipantId').try(:inner_text),
        :first_name => participant.at_css('FirstName').try(:inner_text),
        :last_name => participant.at_css('LastName').try(:inner_text),
        :participant_role => ParticipantRole.find_or_initialize_by(:name => participant.at_css('Role').try(:inner_text)), 
        :primary_contact_phone => participant.at_css('PrimaryContactPhone').try(:inner_text),
        :office_phone => participant.at_css('OfficePhone').try(:inner_text),
        :email => participant.at_css('Email').try(:inner_text),
        :fax => participant.at_css('Fax').try(:inner_text),
        :website_url => participant.at_css('WebsiteURL').try(:inner_text)
      })
      @listing.participants << @participant unless @listing.participants.include? @participant
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

    # Businesses

    %w[brokerage builder franchise].each do |b|
      p.css(b.classify).each do |business|
        @business = b.classify.constantize.find_or_initialize_by(
          :type => b.classify,
          :name => business.at_css('Name').try(:inner_text),
          :phone => business.at_css('Phone').try(:inner_text),  
          :fax => business.at_css('Fax').try(:inner_text),
          :email => business.at_css('Email').try(:inner_text),
          :website_url => business.at_css('WebsiteURL').try(:inner_text),
          :logo_url => business.at_css('LogoURL').try(:inner_text)
        )
        @listing.send(b.pluralize) << @business unless @listing.send(b.pluralize).include? @business

        business.css('Address').each do |address|
          @address = @business.addresses.find_or_initialize_by(
            :preference_order => address.at_css('preference-order').try(:inner_text),
            :address_preference_order => address.at_css('address-preference-order').try(:inner_text),
            :full_street_address => address.at_css('FullStreetAddress').try(:inner_text),
            :unit_number => address.at_css('UnitNumber').try(:inner_text),
            :city => address.at_css('City').try(:inner_text),
            :state_or_province => address.at_css('StateOrProvince').try(:inner_text),
            :postal_code => address.at_css('PostalCode').try(:inner_text),
            :country => address.at_css('Country').try(:inner_text)
          )
          @business.addresses << @address unless @business.addresses.include? @address
        end
      end
    end

    # Listing Offices

    p.css('Offices Office').each do |office|
      @listing.listing_offices.each{|o| o.delete }
      @office = Office.find_or_initialize_by(:office_key => office.at_css('OfficeKey').try(:inner_text))
      @office.assign_attributes({  
        :office_identifier => office.at_css('OfficeId').try(:inner_text),
        :office_code_identifier => office.at_css('OfficeCode OfficeCodeId').try(:inner_text),
        :main_office_identifier => office.at_css('MainOfficeId').try(:inner_text),
        :name => office.at_css('Name').try(:inner_text),
        :corporate_name => office.at_css('CorporateName').try(:inner_text),
        :broker_identifier => office.at_css('BrokerId').try(:inner_text),
        :phone_number => office.at_css('PhoneNumber').try(:inner_text),
        :website => office.at_css('Website').try(:inner_text),
      })
      @listing.offices <<  @office unless @listing.offices.first.try(:office_key).eql? @office.office_key
      office.css('Address').each do |address|
        @office.addresses.find_or_initialize_by(
          :preference_order => address.at_css('preference-order').try(:inner_text),
          :address_preference_order => address.at_css('address-preference-order').try(:inner_text),
          :full_street_address => address.at_css('FullStreetAddress').try(:inner_text),
          :unit_number => address.at_css('UnitNumber').try(:inner_text),
          :city => address.at_css('City').try(:inner_text),
          :state_or_province => address.at_css('StateOrProvince').try(:inner_text),
          :postal_code => address.at_css('PostalCode').try(:inner_text),
          :country => address.at_css('Country').try(:inner_text)
        )
      end
    end

    # Neighborhoods

    @listing.neighborhoods.each{|neighborhood| neighborhood.delete }
    p.css('Neighborhoods Neighborhood').each do |neighborhood|
      @neighborhood = Neighborhood.find_or_initialize_by(
        :name => neighborhood.at_css('Name').try(:inner_text), 
        :description => neighborhood.at_css('Description').try(:inner_text),
        :city => @listing.addresses.first.city,
        :state_or_province => @listing.addresses.first.state_or_province,
        :country => @listing.addresses.first.country
      )
      @listing.neighborhoods << @neighborhood unless @listing.neighborhoods.include? @neighborhood
    end

    # Open Houses

    @listing.open_houses.each{|oh| oh.destroy }
    p.css('OpenHouses OpenHouse').each do |oh|
      @listing.open_houses << OpenHouse.new(
        :showing_date => oh.at_css('Date').try(:inner_text), 
        :start_time => oh.at_css('StartTime').try(:inner_text),
        :end_time => oh.at_css('EndTime').try(:inner_text),
        :description => oh.at_css('Description').try(:inner_text)
      )
    end

    # Taxes

    p.css('Taxes Tax').each do |tax|
      @tax = @listing.taxes.find_or_initialize_by(
        :year => tax.at_css('Year').try(:inner_text), 
        :amount => tax.at_css('Amount').try(:inner_text),
        :description => tax.at_css('TaxDescription').try(:inner_text)
      )
      @listing.taxes << @tax unless @listing.taxes.include? @tax
    end

    # Expenses

    @listing.expenses.each{|expense| expense.destroy}
    p.css('Expenses Expense').each do |expense|
      @expense = @listing.expenses.new(
        :expense_category => ExpenseCategory.find_by(:name => expense.at_css('ExpenseCategory').try(:inner_text)),
        :currency_period => CurrencyPeriod.find_by(:name => expense.at_css('ExpenseValue').attributes['currencyPeriod'].try(:value)),
        :expense_value => expense.at_css('ExpenseValue').try(:inner_text)
      )
      @listing.expenses << @expense unless @listing.expenses.include? @expense
    end

    # Foreclosure Status

    p.css('ForeclosureStatus').each do |foreclosure_status|
      @listing.foreclosure_status = ForeclosureStatus.find_or_create_by(:name => foreclosure_status.try(:inner_text))
    end

    # Rooms

    @listing.rooms.each{|room| room.destroy }
    p.css('Rooms Room').each do |room|
      @listing.rooms << Room.create(:room_category => RoomCategory.find_or_create_by(:name => room.try(:inner_text)))
    end

    @listing.save ? true : false
    
  end
  
end

