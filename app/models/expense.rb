class Expense < ActiveRecord::Base
  belongs_to :expense_category
  belongs_to :currency_period
  belongs_to :listing
  
end
