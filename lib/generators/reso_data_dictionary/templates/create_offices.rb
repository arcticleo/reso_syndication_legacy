class CreateOffices < ActiveRecord::Migration
  def change
    create_table :offices, options: 'DEFAULT CHARSET=utf8' do |t|
      t.string :office_key, null: false
      t.string :office_identifier, null: false
      t.string :level
      t.string :office_code_identifier
      t.string :name, null: false
      t.string :franchise_affiliation
      t.string :corporate_name
      t.string :broker_identifier
      t.string :main_office_identifier
      t.string :phone_number
      t.string :office_fax
      t.string :office_email
      t.string :website
      t.boolean :idx_office_participation_yn
      t.string :main_office_key
      t.string :main_office_mlsid
      t.string :office_broker_key
      t.string :office_broker_mlsid

      t.timestamps
    end
    add_index :offices, :name
    add_index :offices, [:office_identifier, :name]

  end
end