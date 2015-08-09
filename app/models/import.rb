class Import < ActiveRecord::Base

  belongs_to :import_format

  has_many :listings
  has_many :queued_listings
  
  validates_uniqueness_of :token

  before_save :set_import_format

  def set_import_format
    self.import_format = ImportFormat.find_by(name: 'reso') unless self.import_format.present?
  end

end
