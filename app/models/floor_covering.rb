class FloorCovering < Enumeral
  has_and_belongs_to_many :listings, foreign_key: "enumeral_id"
end
