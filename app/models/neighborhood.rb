class Neighborhood < Place
  has_and_belongs_to_many :listings, foreign_key: "place_id"
end
