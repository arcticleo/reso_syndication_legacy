class Business < ActiveRecord::Base

  has_and_belongs_to_many :listings, foreign_key: "business_id"

  validates_presence_of :name
  validates_presence_of :type

end
