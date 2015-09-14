# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'Expression/version'

Gem::Specification.new do |spec|
  spec.name          = "math_expression"
  spec.version       = Expression::VERSION
  spec.authors       = ["mhmd689"]
  spec.email         = ["b689d8@gmail.com"]
  spec.description   = %q{Mathmatical expression calculator}
  spec.summary       = %q{The gem evaluates mathmatical expressions provided as a string}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
