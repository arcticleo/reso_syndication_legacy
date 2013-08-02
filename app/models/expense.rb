class Expense < ActiveRecord::Base
  belongs_to :expense_category
  belongs_to :currency_period
  belongs_to :listing
  
#  validates_presence_of :expense_category
#  validates_presence_of :currency_period

#  validates :expense_value, :numericality => true,
#                            :presence => true

  
end
