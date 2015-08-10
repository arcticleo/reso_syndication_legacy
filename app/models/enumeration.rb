class Enumeration < ActiveRecord::Base

  validates_presence_of :name
  validates_presence_of :type
  validates_uniqueness_of :name, scope: :type

end
