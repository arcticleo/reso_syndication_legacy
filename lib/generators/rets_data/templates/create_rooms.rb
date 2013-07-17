class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.references :room_category, index: true
      t.references :listing, index: true

      t.timestamps
    end
  end
end