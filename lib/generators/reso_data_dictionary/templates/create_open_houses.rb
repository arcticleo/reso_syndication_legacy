class CreateOpenHouses < ActiveRecord::Migration
  def change
    create_table :open_houses, options: 'DEFAULT CHARSET=utf8' do |t|
      t.date :showing_date
      t.time :start_time
      t.time :end_time
      t.text :description
      t.references :listing, index: true, null: false

      t.timestamps
    end
    add_index :open_houses, :showing_date
    add_index :open_houses, :start_time
    add_index :open_houses, :end_time
  end
end