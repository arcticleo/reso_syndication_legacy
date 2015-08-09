class Import < ActiveRecord::Base

  belongs_to :import_format

  has_many :listings
  has_many :queued_listings

end
