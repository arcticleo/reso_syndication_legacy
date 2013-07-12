class CreateListingParticipants < ActiveRecord::Migration
  def change
    create_table :listing_participants do |t|
      t.string :participant_key, :null => false
      t.string :participant_identifier, :null => false
      t.string :first_name
      t.string :last_name
      t.string :role
      t.string :primary_contact_phone
      t.string :office_phone
      t.string :office_phone
      t.string :email
      t.string :fax 
      t.string :website_url

      t.timestamps
    end
  end
end