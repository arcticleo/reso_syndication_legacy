class CreateListingMedia < ActiveRecord::Migration
  def change
    create_table :listing_media do |t|
      t.string :media_url, :null => false
      t.string :media_caption
      t.text :media_description
      t.string :media_modification_timestamp
      t.string :type, :null => false
      t.references :listing, index: true, :null => false 

      t.timestamps
    end
    add_index :listing_media, :type
  end
end