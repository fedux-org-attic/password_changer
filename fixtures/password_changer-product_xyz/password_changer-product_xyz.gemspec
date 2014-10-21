# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'password_changer-product_xyz/version'

Gem::Specification.new do |spec|
  spec.name          = 'password_changer-product_xyz'
  spec.version       = PasswordChanger::ProductXyz::VERSION
  spec.authors       = ['Dennis Günnewig']
  spec.email         = ['dg1@vrnetze.de']
  spec.summary       = %q{This is a stub so that no one can hijack this example gem}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
end
