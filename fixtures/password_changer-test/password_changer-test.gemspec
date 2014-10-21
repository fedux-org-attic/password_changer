# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'password_changer-test/version'

Gem::Specification.new do |spec|
  spec.name          = "password_changer-test"
  spec.version       = PasswordChanger::Test::VERSION
  spec.authors       = ["Dennis Günnewig"]
  spec.email         = ["dg1@vrnetze.de"]
  spec.summary       = %q{test gem}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
end
