class Price < ActiveRecord::Base
  belongs_to :currency_period, optional: true
  belongs_to :listing, optional: true
end
