class Listing < ActiveRecord::Base
  belongs_to :listing_provider
  belongs_to :property_type
  belongs_to :property_sub_type
  belongs_to :listing_category
  belongs_to :listing_status
  belongs_to :listing_service
  belongs_to :zoning_type
  belongs_to :architectural_style
  belongs_to :county
  belongs_to :community
  belongs_to :foreclosure_status

  has_many :expenses, :dependent => :destroy
  has_many :open_houses, :dependent => :destroy
  has_many :rooms, :dependent => :destroy
  has_many :taxes, :dependent => :destroy
  has_many :listing_photos, :dependent => :destroy
  has_many :listing_videos, :dependent => :destroy
  has_many :virtual_tours, :dependent => :destroy

  accepts_nested_attributes_for :expenses, allow_destroy: true
  accepts_nested_attributes_for :rooms, allow_destroy: true
  accepts_nested_attributes_for :taxes, allow_destroy: true
  
  has_and_belongs_to_many :addresses
  has_and_belongs_to_many :listing_participants
  has_and_belongs_to_many :offices

  has_and_belongs_to_many :brokerages, association_foreign_key: "business_id"
  has_and_belongs_to_many :builders, association_foreign_key: "business_id"
  has_and_belongs_to_many :franchises, association_foreign_key: "business_id"

  has_and_belongs_to_many :neighborhoods, association_foreign_key: "place_id"

  has_and_belongs_to_many :appliances, association_foreign_key: "enumeral_id"
  has_and_belongs_to_many :cooling_systems, association_foreign_key: "enumeral_id"
  has_and_belongs_to_many :exterior_types, association_foreign_key: "enumeral_id"
  has_and_belongs_to_many :flooring_materials, association_foreign_key: "enumeral_id"
  has_and_belongs_to_many :heating_fuels, association_foreign_key: "enumeral_id"
  has_and_belongs_to_many :heating_systems, association_foreign_key: "enumeral_id"
  has_and_belongs_to_many :home_features, association_foreign_key: "enumeral_id"
  has_and_belongs_to_many :roof_materials, association_foreign_key: "enumeral_id"
  has_and_belongs_to_many :parking, association_foreign_key: "enumeral_id"
  has_and_belongs_to_many :views, association_foreign_key: "enumeral_id"
  
  accepts_nested_attributes_for :appliances
  accepts_nested_attributes_for :cooling_systems
  accepts_nested_attributes_for :exterior_types
  accepts_nested_attributes_for :flooring_materials
  accepts_nested_attributes_for :heating_fuels
  accepts_nested_attributes_for :heating_systems
  accepts_nested_attributes_for :home_features
  accepts_nested_attributes_for :roof_materials
  accepts_nested_attributes_for :parking
  accepts_nested_attributes_for :views
  
  validates_presence_of :list_price
  validates_presence_of :property_type
  validates_presence_of :property_sub_type
  validates_presence_of :listing_category
  validates_presence_of :listing_status
  
end
