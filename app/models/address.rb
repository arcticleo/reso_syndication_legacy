class Address < ActiveRecord::Base

  belongs_to :address_type
  belongs_to :addressable, polymorphic: true

end
