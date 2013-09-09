class ListingProvider < ActiveRecord::Base
  belongs_to :source_provider_category

  has_many :listings

#  validates_presence_of :name
#  validates_presence_of :source_provider_category

end
