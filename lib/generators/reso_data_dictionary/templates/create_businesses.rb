class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses, options: 'DEFAULT CHARSET=utf8' do |t|
      t.string :name, null: false
      t.string :type, null: false
      t.string :phone
      t.string :fax
      t.string :email
      t.string :website_url
      t.string :logo_url
      t.string :business_additional_information

      t.timestamps
    end
    add_index :businesses, :name
    add_index :businesses, :type
    add_index :businesses, [:name, :type]
  end
end