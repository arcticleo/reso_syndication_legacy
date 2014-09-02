class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants, :options => 'DEFAULT CHARSET=utf8' do |t|
      t.string :participant_key
      t.string :participant_identifier
      t.string :participant_code
      t.string :first_name
      t.string :last_name
      t.references :person, :null => true
      t.references :participant_role, :null => false, index: true
      t.string :primary_contact_phone
      t.string :office_phone
      t.string :mobile_phone
      t.string :email
      t.string :fax 
      t.string :website_url
      t.string :photo_url

      t.timestamps
    end
    add_index :participants, :participant_key
    add_index :participants, :participant_identifier
    add_index :participants, :person_id
  end
end