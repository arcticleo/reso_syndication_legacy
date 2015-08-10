class HomeFeature < Enumeration
  has_and_belongs_to_many :listings, foreign_key: "enumeration_id"
end
