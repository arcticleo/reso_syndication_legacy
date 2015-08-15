class CreateEnumerations < ActiveRecord::Migration
  def change
    create_table :enumerations, options: 'DEFAULT CHARSET=utf8' do |t|
      t.string :name, null: false, limit: 128
      t.string :type, null: false

      t.timestamps
    end
    add_index :enumerations, :name
    add_index :enumerations, :type
    add_index :enumerations, [:name, :type]
  end
end