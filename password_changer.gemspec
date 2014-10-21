# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'password_changer/version'

Gem::Specification.new do |spec|
  spec.name          = 'password_changer'
  spec.version       = PasswordChanger::VERSION
  spec.authors       = ['Dennis Günnewig']
  spec.email         = ['dg1@vrnetze.de']
  spec.summary       = %q{Change password}
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'levenshtein-ffi'
  spec.add_runtime_dependency 'thor'
  spec.add_runtime_dependency 'highline'
  spec.add_runtime_dependency 'i18n'
  spec.add_runtime_dependency 'hirb'

  spec.add_dependency 'fedux_org-stdlib', '>= 0.6.50'
end
