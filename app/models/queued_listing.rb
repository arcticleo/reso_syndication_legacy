class QueuedListing < ActiveRecord::Base
  belongs_to :import
  serialize :listing_data
  after_save :create_listing_and_remove_myself

  def mapper
    "Mapper::#{self.import.import_format.name.downcase.capitalize}".constantize
  end

  def create_or_update_listing
    listing = self.import.listings.
      eager_load(:address).
      eager_load(:appliances).
      eager_load(:participants).
      eager_load(:photos).
      find_or_initialize_by(
        listing_key: Mapper::unique_identifier(self)
      )
    if (listing.modification_timestamp != mapper.modification_timestamp(self, listing))
      Mapper::RESO_LISTING_ATTRIBUTES.each do |attribute|
        listing.send("#{attribute}=", mapper.send(attribute, self, listing))
      end
#      if listing.id
        listing.save
#      else
#        Listing.import [listing], validate: false#, on_duplicate_key_update:  
#      end
    end
  end

  def create_listing_and_remove_myself
    create_or_update_listing ? self.destroy : false 
  end
  
end
