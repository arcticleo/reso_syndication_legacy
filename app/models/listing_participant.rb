class ListingParticipant < ActiveRecord::Base

#  validates_presence_of :participant_key
#  validates_presence_of :participant_identifier
#  validates_uniqueness_of :participant_key

  has_many :listing_participant_licenses

end
