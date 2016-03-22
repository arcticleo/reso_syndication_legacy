class Address < ActiveRecord::Base

  belongs_to :address_type, optional: true
  belongs_to :addressable, polymorphic: true, optional: true

  before_save :validate_and_sanitize_us_address
  
  def address_concatenated
    [self.full_street_address, self.city, self.state_or_province, self.postal_code].join(', ')
  end
  
  def validate_and_sanitize_us_address
    if (address = StreetAddress::US.parse(self.address_concatenated))
      self.street_number = address.number
      self.street_dir_prefix = address.prefix
      self.street_name = address.street
      self.street_suffix = address.street_type
      self.street_dir_suffix = address.suffix
      self.unit_number = address.unit unless address.unit.blank?
      self.state_or_province = address.state
      self.country = 'US'
    end
  end

end
