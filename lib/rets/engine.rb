require "rets"
require "rails"

module Rets
  class Engine < ::Rails::Engine
    engine_name :rets

    rake_tasks do
        load "rets/railties/tasks.rake"
      end

  end
end