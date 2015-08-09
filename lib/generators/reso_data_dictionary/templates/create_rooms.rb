class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms, options: 'DEFAULT CHARSET=utf8' do |t|
      t.references :room_category, index: true
      t.references :listing, index: true, foreign_key: true

      t.timestamps
    end
  end
end