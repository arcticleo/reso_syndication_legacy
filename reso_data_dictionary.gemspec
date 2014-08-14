# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reso_data_dictionary/version'

Gem::Specification.new do |spec|
  spec.name          = "reso_data_dictionary"
  spec.version       = RetsData::VERSION
  spec.authors       = ["Michael Edlund"]
  spec.email         = ["medlund@mac.com"]
  spec.description   = %q{RESO Data Dictionary data models and import with AWS SQS support.}
  spec.summary       = %q{The reso_data_dictionary gem provides models and data import based on the Real Estate Standards Organizations RETS Syndication Format for exchange of real estate listing data. Supports AWS SQS (Simple Queue Service) for queuing and parallel processing for fast import of large data sets.}
  spec.homepage      = "http://github.com/arcticleo/reso_data_dictionary"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec", "~> 2.6"
  spec.add_dependency "rails", '~> 4.0', '>= 4.0.0'
  spec.add_dependency "aws-sdk"
  spec.add_dependency "nokogiri"
  spec.add_dependency "rainbow", '~> 2.0', '>= 2.0.0'
end
