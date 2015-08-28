namespace :reso do

  desc "Populate database with seed data."
  task :seed => [:load_enumerations, :seed_imports] 

  task :load_enumerations => [:environment] do
    require "csv"
    csv_text = File.read("#{Rails.root}/db/enumerations.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      row = row.to_hash.with_indifferent_access
      Enumeration.find_or_create_by(row.to_hash.symbolize_keys)
        puts row.inspect
      end
      puts
  end

  task :seed_imports => [:environment] do
    imports = [{ name: "RESO Example", 
                 token: "reso",
                 import_format_id: ImportFormat.find_by(name: 'reso').id,
                 source_url: "https://app.listhub.com/syndication-docs/example.xml"
              }]
  
    imports.each do |import|
      @import = Import.new
      import.each_pair{|key, value| @import[key] = value }
      @import.save
    end
  end

  desc "Download and import data file for specified import."
  task :import, [:import_token] => [:environment] do |t, args|
    args.with_defaults(:import_token => "reso")
    Import.find_by(token: args.import_token).run_import
  end

end
