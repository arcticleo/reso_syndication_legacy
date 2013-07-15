class CreateOffices < ActiveRecord::Migration
  def change
    create_table :offices do |t|
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
    add_index :offices, :office_identifier
    add_index :offices, :broker_identifier
    add_index :offices, :main_office_identifier
  end
end