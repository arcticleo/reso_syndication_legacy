class ListingParticipant < ActiveRecord::Base

  validates_presence_of :participant_key
  validates_presence_of :participant_identifier

  has_many :listing_participant_licenses

end
