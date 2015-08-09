class CreateListingMedia < ActiveRecord::Migration
  def change
    create_table :listing_media, options: 'DEFAULT CHARSET=latin1' do |t|
      t.integer :media_order_number
      t.string :media_url, null: false, limit: 512 
      t.string :media_caption
      t.text :media_description
      t.string :media_modification_timestamp
      t.string :type, null: false
      t.references :listing, index: true, null: false, foreign_key: true 

      t.timestamps
    end
    add_index :listing_media, :media_order_number
    add_index :listing_media, :type
    add_index :listing_media, [:listing_id, :media_order_number]
    add_index :listing_media, [:media_url, :media_modification_timestamp], name: "on_url_and_timestamp"
  end
end