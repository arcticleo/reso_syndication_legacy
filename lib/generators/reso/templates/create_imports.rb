class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.string :name
      t.string :token
      t.string :source_format, default: "reso"
      t.string :repeating_element, default: "Listing"
      t.string :unique_identifier, default: "ListingKey"
      t.string :source_url
      t.string :source_user
      t.string :source_pass

      t.timestamps null: false
    end
    add_index :imports, :token
  end
end
