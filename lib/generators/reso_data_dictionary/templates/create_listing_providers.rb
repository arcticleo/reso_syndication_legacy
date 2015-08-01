class CreateListingProviders < ActiveRecord::Migration
  def change
    create_table :listing_providers, :options => 'DEFAULT CHARSET=utf8' do |t|
      t.string :name, null: false
      t.string :url
      t.references :source_provider_category, null: false, index: true

      t.timestamps
    end
  end
end