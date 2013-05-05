# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'geovis/version'

Gem::Specification.new do |spec|
  spec.name          = "geovis"
  spec.version       = GeoVis::VERSION
  spec.authors       = ["Robert Pyke"]
  spec.email         = ["robert.j.pyke@gmail.com"]
  spec.description   = %q{GeoVis}
  spec.summary       = %q{GeoVis}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # Development Dependencies
  spec.add_development_dependency('bundler')
  spec.add_development_dependency('rake')
  spec.add_development_dependency('test-unit', '~> 2.5.4')
  spec.add_development_dependency('rdoc')

  # Deployed Gem Dependencies
  spec.add_dependency('rgeo', '~> 0.3.20')
  spec.add_dependency('rgeo-geojson', '~> 0.2.3')
  spec.add_dependency('rgeo-activerecord')
end
