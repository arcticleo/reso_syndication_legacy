require "reso_data_dictionary"
require "rails"

module ResoDataDictionary
  class Engine < ::Rails::Engine
    engine_name :reso_data_dictionary

    rake_tasks do
      load "reso_data_dictionary/railties/tasks.rake"
    end

  end
end
