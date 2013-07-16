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
  belongs_to :foreclosure_status

  has_many :expenses
  has_many :open_houses
  has_many :rooms
  has_many :taxes
  has_many :listing_photos
  has_many :listing_videos
  has_many :virtual_tours
  
  has_and_belongs_to_many :addresses
  has_and_belongs_to_many :listing_participants
  has_and_belongs_to_many :offices

  has_and_belongs_to_many :brokerages, association_foreign_key: "business_id"
  has_and_belongs_to_many :builders, association_foreign_key: "business_id"
  has_and_belongs_to_many :franchises, association_foreign_key: "business_id"

  has_and_belongs_to_many :communities, association_foreign_key: "place_id"
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
  
  validates_presence_of :list_price
  validates_presence_of :property_type
  validates_presence_of :property_sub_type
  validates_presence_of :listing_category
  validates_presence_of :listing_status
  
end
