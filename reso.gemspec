# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reso/version'

Gem::Specification.new do |spec|
  spec.name          = "reso"
  spec.version       = Reso::VERSION
  spec.authors       = ["Michael Edlund"]
  spec.email         = ["medlund@mac.com"]
  spec.description   = %q{RESO Data Dictionary data models and import.}
  spec.summary       = %q{The RESO Data Dictionary gem provides models and data import based on the Real Estate Standards Organization Syndication Format for exchange of real estate listing data.}
  spec.homepage      = "http://github.com/arcticleo/reso"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", '~> 10'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec", "~> 2.6"
  spec.add_dependency "rails", '~> 4.0', '>= 4.0.0'
  spec.add_dependency "nokogiri", '~> 1'
  spec.add_dependency 'chronic', '~> 0'
  spec.add_dependency 'open_uri_redirections', '~> 0'
end
