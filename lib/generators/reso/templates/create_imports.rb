class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.integer     :status, default: 0
      t.string      :name
      t.string      :token
      t.references  :import_format, index: true
      t.string      :repeating_element, default: "Listing"
      t.string      :unique_identifier, default: "ListingKey"
      t.string      :source_url
      t.string      :source_user
      t.string      :source_pass
      t.datetime    :source_data_modified

      t.timestamps null: false
    end
    add_index :imports, :token
  end
end
