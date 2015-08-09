class CreateMultipleListingServices < ActiveRecord::Migration
  def change
    create_table :multiple_listing_services, options: 'DEFAULT CHARSET=utf8' do |t|
      t.string :mls_id
      t.string :mls_name

      t.timestamps
    end
    add_index :multiple_listing_services, [:mls_id, :mls_name]
  end
end