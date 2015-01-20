class CreateOffices < ActiveRecord::Migration
  def change
    create_table :offices, :options => 'DEFAULT CHARSET=utf8' do |t|
      t.string :office_key, :null => false
      t.string :office_identifier, :null => false
      t.string :level
      t.string :office_code_identifier
      t.string :name, :null => false
      t.string :corporate_name
      t.string :broker_identifier
      t.string :main_office_identifier
      t.string :phone_number
      t.string :fax_number
      t.string :office_email
      t.string :website

      t.timestamps
    end
    add_index :listing_offices, :office_key
    add_index :listing_offices, :office_identifier
    add_index :listing_offices, :office_code_identifier
    add_index :listing_offices, :broker_identifier
    add_index :listing_offices, :main_office_identifier
  end
end