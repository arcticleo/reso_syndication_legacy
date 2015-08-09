class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses, options: 'DEFAULT CHARSET=utf8' do |t|
      t.references :expense_category, index: true
      t.references :currency_period, index: true
      t.decimal :expense_value
      t.references :listing, index: true, null: false

      t.timestamps
    end
    add_index :expenses, [:expense_category_id, :currency_period_id, :expense_value], name: "index_on_category_and_currency_period_and_value"
  end
end