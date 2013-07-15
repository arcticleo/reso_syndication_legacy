require "rets_syndication"
require "rails"

module RetsSyndication
  class Engine < ::Rails::Engine
    engine_name :rets_syndication

    rake_tasks do
        load "rets_syndication/railties/tasks.rake"
      end

  end
end