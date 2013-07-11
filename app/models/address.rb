class Address < ActiveRecord::Base

  validates_presence_of :preference_order
  validates_presence_of :address_preference_order
  validates_presence_of :full_street_address
  validates_presence_of :country

  has_and_belongs_to_many :listings

end
