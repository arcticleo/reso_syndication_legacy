class CreateTaxes < ActiveRecord::Migration
  def change
    create_table :taxes, :options => 'DEFAULT CHARSET=utf8' do |t|
      t.integer :year
      t.decimal :amount, :null => false
      t.string :description
      t.references :listing, index: true, :null => false

      t.timestamps
    end
  end
end