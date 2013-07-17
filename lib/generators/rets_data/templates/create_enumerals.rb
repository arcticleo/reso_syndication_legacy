class CreateEnumerals < ActiveRecord::Migration
  def change
    create_table :enumerals do |t|
      t.string :name, :null => false, index: true
      t.string :type, :null => false, index: true

      t.timestamps
    end
    add_index :enumerals, :name
    add_index :enumerals, :type
  end
end