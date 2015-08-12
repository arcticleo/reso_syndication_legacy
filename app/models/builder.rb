class Builder < Business
  has_many :listings
  has_one :address, as: :addressable
end
