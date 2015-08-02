class Address < ActiveRecord::Base

  belongs_to :address_type
  has_and_belongs_to_many :listings

end
