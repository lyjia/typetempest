# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'type_tempest/version'

Gem::Specification.new do |spec|
  spec.name          = "type_tempest"
  spec.version       = TypeTempest::VERSION
  spec.authors       = ["Lyjia / Tom Corelis"]
  spec.email         = ["tom@tomcorelis.com"]
  spec.description   = %q{Simple type-checking for Ruby}
  spec.summary       = %q{Simple type-checking for Ruby}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
