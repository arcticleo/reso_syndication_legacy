class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :preference_order, :null => false, :default => 1 
      t.integer :address_preference_order, :null => false, :default => 1
      t.string :full_street_address
      t.string :unit_number
      t.string :city
      t.string :state_or_province
      t.string :postal_code
      t.string :country, :default => "US"

      t.timestamps
    end
    add_index :addresses, :city
    add_index :addresses, :state_or_province
    add_index :addresses, :country
  end
end