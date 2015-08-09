class QueuedListing < ActiveRecord::Base
  belongs_to :import
  serialize :listing_data
  after_save :create_listing_and_remove_myself

  def mapper
    "Mapper::#{self.import.import_format.name.downcase.capitalize}".constantize
  end

  def create_listing_and_remove_myself
    mapper.create_or_update_listing(self) ? self.destroy : false 
  end
  
end
