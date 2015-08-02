class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places, options: 'DEFAULT CHARSET=utf8' do |t|
      t.string :name, null: false
      t.string :city
      t.string :state_or_province
      t.string :country, null: false, default: "US"
      t.string :type, null: false
      t.text :description

      t.timestamps
    end
    add_index :places, :name
    add_index :places, :city
    add_index :places, :state_or_province
    add_index :places, :country
    add_index :places, :type
  end
end