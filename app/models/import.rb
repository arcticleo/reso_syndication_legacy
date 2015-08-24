class Import < ActiveRecord::Base

  belongs_to :import_format

  has_many :listings
  has_many :queued_listings
  
  validates_uniqueness_of :token

  before_save :set_import_format

  def remove_listings_not_present fresh_listing_keys
    existing_listing_keys = self.listings.all.pluck(:listing_key)
    stale_listing_keys = existing_listing_keys.delete_if{|key| fresh_listing_keys.include? key }
    stale_listing_keys.each do |listing_key|
      Listing.find_by(listing_key: listing_key).destroy
    end
    stale_listing_keys
  end

  def set_import_format
    self.import_format = ImportFormat.find_by(name: 'reso') unless self.import_format.present?
  end

end
