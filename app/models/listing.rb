class Listing < ActiveRecord::Base

  belongs_to :architecture_style
  belongs_to :brokerage
  belongs_to :community
  belongs_to :county
  belongs_to :foreclosure_status
  belongs_to :franchise
  belongs_to :import
  belongs_to :listing_category
  belongs_to :listing_provider
  belongs_to :listing_status
  belongs_to :mls
  belongs_to :property_sub_type
  belongs_to :property_type
  belongs_to :office
  belongs_to :zoning_type

  has_one :address, as: :addressable

  has_many :alternate_prices, dependent: :destroy
  has_many :expenses, dependent: :destroy
  has_many :open_houses, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :taxes, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :videos, dependent: :destroy
  has_many :virtual_tours, dependent: :destroy
  
  has_many :people, through: :participants

  accepts_nested_attributes_for :alternate_prices, allow_destroy: true
  accepts_nested_attributes_for :expenses, allow_destroy: true
  accepts_nested_attributes_for :open_houses, allow_destroy: true
  accepts_nested_attributes_for :rooms, allow_destroy: true
  accepts_nested_attributes_for :taxes, allow_destroy: true
  
  has_and_belongs_to_many :participants

  accepts_nested_attributes_for :participants, allow_destroy: true

  has_and_belongs_to_many :builders, association_foreign_key: "business_id"

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

end

