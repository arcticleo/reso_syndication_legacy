class Participant < ActiveRecord::Base
  belongs_to :participant_role
  has_many :participant_licenses
  has_and_belongs_to_many :listings
end
