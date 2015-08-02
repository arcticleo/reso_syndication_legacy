class CreateMls < ActiveRecord::Migration
  def change
    create_table :mls, options: 'DEFAULT CHARSET=utf8' do |t|
      t.string :mls_id
      t.string :mls_name

      t.timestamps
    end
  end
end