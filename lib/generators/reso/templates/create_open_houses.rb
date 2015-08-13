class CreateOpenHouses < ActiveRecord::Migration
  def change
    create_table :open_houses, options: 'DEFAULT CHARSET=utf8' do |t|
      t.date :showing_date

      # TODO: Does RESO provide a way to specify time zone?
      t.string :start_time
      t.string :end_time
      t.text :description
      t.references :listing, index: true, null: false, foreign_key: true

      t.timestamps
    end
    add_index :open_houses, :showing_date
    add_index :open_houses, [:showing_date, :start_time, :end_time]
  end
end