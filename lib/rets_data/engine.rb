require "rets_data"
require "rails"

module RetsData
  class Engine < ::Rails::Engine
    engine_name :rets_data

    rake_tasks do
        load "rets_data/railties/tasks.rake"
      end

  end
end