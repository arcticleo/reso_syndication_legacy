class ImportResult < ActiveRecord::Base
  belongs_to :import
  serialize :found_listing_keys
  serialize :removed_listing_keys
  serialize :snapshots
end
