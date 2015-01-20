class Office < ActiveRecord::Base

  has_and_belongs_to_many :addresses
  belongs_to :listing
  belongs_to :office

  def address
    self.addresses.first
  end

end
