class School < ActiveRecord::Base
  belongs_to :school_category, optional: true
end
