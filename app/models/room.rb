class Room < ActiveRecord::Base
  belongs_to :room_category, optional: true
  belongs_to :listing, optional: true
end
