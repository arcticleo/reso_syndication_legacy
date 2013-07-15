class CreateTaxes < ActiveRecord::Migration
  def change
    create_table :taxes do |t|
      t.integer :year
      t.decimal :amount, :null => false
      t.string :description
      t.references :listing, index: true, :null => false

      t.timestamps
    end
  end
end