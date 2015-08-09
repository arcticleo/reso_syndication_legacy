class Import < ActiveRecord::Base
  belongs_to :user
  has_many :listings
  has_many :queued_listings
end
