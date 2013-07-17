require 'rails/generators/migration'

class RetsData < Rails::Generators::Base
  include Rails::Generators::Migration

  def self.source_root
    @_setup_source_root ||= File.expand_path("../templates", __FILE__)
  end

  def self.next_migration_number(path)
    Time.now.utc.strftime("%Y%m%d%H%M%S")
  end

  def create_model_file
#    template "comment.rb", "app/models/comment.rb"
    migration_template "create_addresses.rb", "db/migrate/create_addresses.rb"
    migration_template "create_businesses.rb", "db/migrate/create_businesses.rb"
    migration_template "create_enumerals.rb", "db/migrate/create_enumerals.rb"
    migration_template "create_expenses.rb", "db/migrate/create_expenses.rb"
    migration_template "create_listing_media.rb", "db/migrate/create_listing_media.rb"
    migration_template "create_listing_participants.rb", "db/migrate/create_listing_participants.rb"
    migration_template "create_listing_participant_licenses.rb", "db/migrate/create_listing_participant_licenses.rb"
    migration_template "create_listing_providers.rb", "db/migrate/create_listing_providers.rb"
    migration_template "create_listing_services.rb", "db/migrate/create_listing_services.rb"
    migration_template "create_listings.rb", "db/migrate/create_listings.rb"
    migration_template "create_offices.rb", "db/migrate/create_offices.rb"
    migration_template "create_open_houses.rb", "db/migrate/create_open_houses.rb"
    migration_template "create_places.rb", "db/migrate/create_places.rb"
    migration_template "create_rooms.rb", "db/migrate/create_rooms.rb"
    migration_template "create_schools.rb", "db/migrate/create_schools.rb"
    migration_template "create_taxes.rb", "db/migrate/create_taxes.rb"
    migration_template "create_join_tables.rb", "db/migrate/create_join_tables.rb"
  end
end