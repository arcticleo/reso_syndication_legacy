class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices, :options => 'DEFAULT CHARSET=utf8' do |t|
      t.references  :listing, index: true, null: false
      t.references  :currency_period, index: true

      t.string :type, null: false
      t.integer     :list_price, limit: 8
      t.string      :currency_code, default: "USD"
      t.integer     :list_price_low, limit: 8
      t.string      :currency_code_low, default: "USD"

      t.timestamps
    end
    add_index :prices, [:list_price, :currency_code]
    add_index :prices, :list_price
    add_index :prices, :type
  end
end