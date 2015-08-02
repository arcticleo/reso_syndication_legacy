module ResoDataDictionary
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path("../templates", __FILE__)

      desc "Copy RESO Data Dictionary migration files to your application."


      def self.next_migration_number(path)
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      end

      def create_model_file
        template "enumerals.csv", "db/enumerals.csv"
        template "example.xml", "db/example.xml"
        %w[addresses 
           businesses 
           enumerals 
           expenses 
           listings
           listing_media 
           listing_providers 
           listing_offices
           mls
           open_houses
           offices
           people
           participants 
           participant_licenses 
           places
           prices
           rooms
           schools
           taxes
           join_tables].each do |name|
             migration_template "create_#{name}.rb", "db/migrate/create_#{name}.rb"
             sleep 1
           end
      end

    end
  end
end