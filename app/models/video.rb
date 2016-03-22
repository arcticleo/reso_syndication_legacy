class Video < ListingMedia
  belongs_to :listing, optional: true
end
