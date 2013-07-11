class ListingMedia < ActiveRecord::Base

  validates_presence_of :media_url
  validates_presence_of :type

end

class ListingPhoto < ListingMedia
end

class ListingVideo < ListingMedia
end

class VirtualTour < ListingMedia
end

