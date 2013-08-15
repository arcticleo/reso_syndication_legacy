class CreateListingParticipantLicenses < ActiveRecord::Migration
  def change
    create_table :listing_participant_licenses, :options => 'DEFAULT CHARSET=utf8' do |t|
      t.references :license_category, index: true, :null => false
      t.string :license_number
      t.string :jurisdiction
      t.string :state_or_province
      t.references :listing_participant, index: true, :null => false

      t.timestamps
    end
  end
end