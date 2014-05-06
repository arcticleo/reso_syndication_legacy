# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rets_data/version'

Gem::Specification.new do |spec|
  spec.name          = "rets_data"
  spec.version       = RetsData::VERSION
  spec.authors       = ["Michael Edlund"]
  spec.email         = ["medlund@mac.com"]
  spec.description   = %q{RETS syndication specification data models.}
  spec.summary       = %q{Provides core real estate listing models based on RETS syndication specification.}
  spec.homepage      = "http://github.com/arcticleo/rets_data"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec", "~> 2.6"
  spec.add_dependency "rails", '~> 4.0', '>= 4.0.0'
  spec.add_dependency "nokogiri"
  spec.add_dependency "rainbow", '~> 2.0', '>= 2.0.0'
end
