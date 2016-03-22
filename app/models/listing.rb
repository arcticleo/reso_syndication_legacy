class Listing < ActiveRecord::Base

  belongs_to :architecture_style, optional: true
  belongs_to :brokerage, optional: true
  belongs_to :builder, optional: true
  belongs_to :community, optional: true
  belongs_to :county, optional: true
  belongs_to :foreclosure_status, optional: true
  belongs_to :franchise, optional: true
  belongs_to :import, optional: true
  belongs_to :listing_category, optional: true
  belongs_to :listing_provider, optional: true
  belongs_to :listing_status, optional: true
  belongs_to :multiple_listing_service, optional: true
  belongs_to :property_sub_type, optional: true
  belongs_to :property_type, optional: true
  belongs_to :office, optional: true
  belongs_to :zoning_type, optional: true

  has_one :address, as: :addressable, dependent: :destroy

  has_many :alternate_prices, dependent: :destroy
  has_many :expenses, dependent: :destroy
  has_many :open_houses, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :people, through: :participants
  has_many :rooms, dependent: :destroy
  has_many :taxes, dependent: :destroy
  has_many :videos, dependent: :destroy
  has_many :virtual_tours, dependent: :destroy
  
  has_and_belongs_to_many :appliances, association_foreign_key: "enumeration_id"
  has_and_belongs_to_many :cooling_systems, association_foreign_key: "enumeration_id"
  has_and_belongs_to_many :exterior_types, association_foreign_key: "enumeration_id"
  has_and_belongs_to_many :floor_coverings, association_foreign_key: "enumeration_id"
  has_and_belongs_to_many :heating_fuels, association_foreign_key: "enumeration_id"
  has_and_belongs_to_many :heating_systems, association_foreign_key: "enumeration_id"
  has_and_belongs_to_many :home_features, association_foreign_key: "enumeration_id"
  has_and_belongs_to_many :neighborhoods, association_foreign_key: "place_id"
  has_and_belongs_to_many :parking, association_foreign_key: "enumeration_id"
  has_and_belongs_to_many :participants
  has_and_belongs_to_many :roof_types, association_foreign_key: "enumeration_id"
  has_and_belongs_to_many :view_types, association_foreign_key: "enumeration_id"

  accepts_nested_attributes_for :alternate_prices, allow_destroy: true
  accepts_nested_attributes_for :appliances
  accepts_nested_attributes_for :cooling_systems
  accepts_nested_attributes_for :expenses, allow_destroy: true
  accepts_nested_attributes_for :exterior_types
  accepts_nested_attributes_for :floor_coverings
  accepts_nested_attributes_for :heating_fuels
  accepts_nested_attributes_for :heating_systems
  accepts_nested_attributes_for :home_features
  accepts_nested_attributes_for :neighborhoods
  accepts_nested_attributes_for :open_houses, allow_destroy: true
  accepts_nested_attributes_for :parking
  accepts_nested_attributes_for :participants, allow_destroy: true
  accepts_nested_attributes_for :roof_types
  accepts_nested_attributes_for :rooms, allow_destroy: true
  accepts_nested_attributes_for :taxes, allow_destroy: true
  accepts_nested_attributes_for :view_types

end

