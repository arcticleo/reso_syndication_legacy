class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.references :expense_category, index: true, :null => false
      t.references :currency_period, index: true, :null => false
      t.decimal :expense_value, :null => false
      t.references :listing, index: true, :null => false

      t.timestamps
    end
  end
end