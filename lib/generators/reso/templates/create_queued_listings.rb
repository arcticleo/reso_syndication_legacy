class CreateQueuedListings < ActiveRecord::Migration
  def change
    create_table :queued_listings do |t|
      t.references :import, index: true, foreign_key: true
      t.text :listing_data

      t.timestamps null: false
    end
  end
end
