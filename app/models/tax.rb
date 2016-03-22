class Tax < ActiveRecord::Base
  belongs_to :listing, optional: true
end
