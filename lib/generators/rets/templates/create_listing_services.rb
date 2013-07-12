class CreateListingServices < ActiveRecord::Migration
  def change
    create_table :listing_services do |t|
      t.string :identifier, :null => false
      t.string :name, :null => false

      t.timestamps
    end
  end
end