class ParticipantLicense < ActiveRecord::Base
  belongs_to :license_category
  belongs_to :participant
  
#  validates_presence_of :license_category
#  validates_presence_of :participant
  
end
