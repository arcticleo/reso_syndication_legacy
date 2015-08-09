class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people, options: 'DEFAULT CHARSET=utf8' do |t|
      t.string :person_key      # 123-1234-ABCD
      t.string :personal_title  # Mr, Ms, Miss, Mrs, Dr.
      t.string :first_name      # Edwin
      t.string :middle_name     # E.
      t.string :nick_name       # Buzz
      t.string :last_name       # Aldrin
      t.string :suffix          # Jr., Sr., MD, DDS
      t.date   :birthdate       # 1972-08-20
      t.references :gender
      t.string :preferred_locale, default: "en-US" # en-US
      t.string :modification_timestamp
      t.timestamps
    end
  end
end
