class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses, options: 'DEFAULT CHARSET=utf8' do |t|
      t.references :expense_category, index: true
      t.references :currency_period, index: true
      t.decimal :expense_value
      t.references :listing, index: true, null: false

      t.timestamps
    end
  end
end