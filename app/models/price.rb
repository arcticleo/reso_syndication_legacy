class Price < ActiveRecord::Base
  belongs_to :currency_period
  belongs_to :listing
end
