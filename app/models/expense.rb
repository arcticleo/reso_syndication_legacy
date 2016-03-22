class Expense < ActiveRecord::Base
  belongs_to :expense_category, optional: true
  belongs_to :currency_period, optional: true
  belongs_to :listing, optional: true
  
end
