class Brokerage < Business
  has_many :listings
  has_one :address, as: :addressable
end
