class Office < ActiveRecord::Base

  has_many :listings
  has_one :address, as: :addressable

end
