class CreateListingOffices < ActiveRecord::Migration
  def change
    create_table :listing_offices, options: 'DEFAULT CHARSET=utf8' do |t|
      t.references :office, null: false, index: true
      t.references :listing, null: false, index: true

      t.timestamps
    end
  end
end