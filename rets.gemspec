# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rets/version'

Gem::Specification.new do |spec|
  spec.name          = "rets"
  spec.version       = Rets::VERSION
  spec.authors       = ["Michael Edlund"]
  spec.email         = ["medlund@mac.com"]
  spec.description   = %q{Provides core real estate listing data models based on RETS syndication specification.}
  spec.summary       = %q{Provides core real estate listing data models based on RETS syndication specification.}
  spec.homepage      = "http://github.com/arcticleo/rets"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.6"
end
