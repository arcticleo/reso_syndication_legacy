class ListingOffice < ActiveRecord::Base

  has_and_belongs_to_many :addresses
  has_and_belongs_to_many :listings

end
