class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools, :options => 'DEFAULT CHARSET=utf8' do |t|
      t.string :name
      t.references :school_category, index: true, :null => false
      t.string :district
      t.text :description

      t.timestamps
    end
  end
end