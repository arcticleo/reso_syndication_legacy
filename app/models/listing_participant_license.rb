class ListingParticipantLicense < ActiveRecord::Base
  belongs_to :license_category
  belongs_to :listing_participant
  
#  validates_presence_of :license_category
#  validates_presence_of :listing_participant
  
end
