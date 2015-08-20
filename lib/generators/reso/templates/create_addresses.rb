class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses, options: 'DEFAULT CHARSET=utf8' do |t|
      t.string :addressable_type
      t.references :addressable, index: true

      t.integer :preference_order, default: 1 
      t.integer :address_preference_order, default: 1
      t.string :full_street_address
      t.integer :street_number, limit: 8
      t.string :street_dir_prefix
      t.string :street_name
      t.string :street_suffix
      t.string :street_dir_suffix
      t.string :street_additional_info
      t.integer :box_number
      t.string :unit_number
      t.string :city
      t.string :state_or_province
      t.string :postal_code
      t.string :carrier_route
      t.string :country, default: "US"
      t.references :address_type

      t.timestamps
    end
    add_index :addresses, :city
    add_index :addresses, :state_or_province
    add_index :addresses, :postal_code
    add_index :addresses, :country
    add_index :addresses, :addressable_type
  end
end