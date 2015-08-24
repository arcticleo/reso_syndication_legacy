class Import < ActiveRecord::Base

  require 'open-uri'
  require 'open_uri_redirections'

  before_save :set_import_format
  belongs_to :import_format
  has_many :listings
  has_many :queued_listings
  validates_uniqueness_of :token

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

  def source_url_last_modified
    open(self.source_url, 
      http_basic_authentication: [self.source_user, self.source_pass], 
      allow_redirections: :all
    ){|f| return f.last_modified }
  end
  
  def new_source_data_exists?
    self.source_data_modified.eql? self.source_url_last_modified ? false : true
  end

end
