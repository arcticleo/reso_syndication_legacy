class Builder < Business
  has_one :address, as: :addressable
end
