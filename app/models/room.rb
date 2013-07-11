class Room < ActiveRecord::Base
  belongs_to :room_category
  belongs_to :listing
end
