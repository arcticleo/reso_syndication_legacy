module Rets
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path("../templates", __FILE__)

      desc "Copy RETS migration files to your application."


      def self.next_migration_number(path)
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      end

      def create_model_file
        template "enumerals.csv", "db/enumerals.csv"
        template "example.xml", "db/example.xml"

        migration_template "create_addresses.rb", "db/migrate/create_addresses.rb"
        sleep 1
        migration_template "create_businesses.rb", "db/migrate/create_businesses.rb"
        sleep 1
        migration_template "create_enumerals.rb", "db/migrate/create_enumerals.rb"
        sleep 1
        migration_template "create_expenses.rb", "db/migrate/create_expenses.rb"
        sleep 1
        migration_template "create_listing_media.rb", "db/migrate/create_listing_media.rb"
        sleep 1
        migration_template "create_listing_participants.rb", "db/migrate/create_listing_participants.rb"
        sleep 1
        migration_template "create_listing_participant_licenses.rb", "db/migrate/create_listing_participant_licenses.rb"
        sleep 1
        migration_template "create_listing_providers.rb", "db/migrate/create_listing_providers.rb"
        sleep 1
        migration_template "create_listing_services.rb", "db/migrate/create_listing_services.rb"
        sleep 1
        migration_template "create_listings.rb", "db/migrate/create_listings.rb"
        sleep 1
        migration_template "create_offices.rb", "db/migrate/create_offices.rb"
        sleep 1
        migration_template "create_open_houses.rb", "db/migrate/create_open_houses.rb"
        sleep 1
        migration_template "create_places.rb", "db/migrate/create_places.rb"
        sleep 1
        migration_template "create_rooms.rb", "db/migrate/create_rooms.rb"
        sleep 1
        migration_template "create_schools.rb", "db/migrate/create_schools.rb"
        sleep 1
        migration_template "create_taxes.rb", "db/migrate/create_taxes.rb"
        sleep 1
        migration_template "create_join_tables.rb", "db/migrate/create_join_tables.rb"
      end

    end
  end
end