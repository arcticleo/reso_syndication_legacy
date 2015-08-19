require "reso"
require "rails"

module Reso
  class Engine < ::Rails::Engine
    engine_name :reso

    rake_tasks do
      # load "reso/railties/reso.rake"
    end

  end
end
