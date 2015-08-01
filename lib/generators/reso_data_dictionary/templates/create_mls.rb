class CreateMls < ActiveRecord::Migration
  def change
    create_table :mls, :options => 'DEFAULT CHARSET=utf8' do |t|
      t.string :mls_id, null: false
      t.string :mls_name, null: false

      t.timestamps
    end
  end
end