# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'find_t/version'

Gem::Specification.new do |spec|
  spec.name          = 'find_t'
  spec.version       = FindT::VERSION
  spec.authors       = ['Yuki Iwanaga']
  spec.email         = ['yuki@creasty.com']
  spec.summary       = %q{Find locale files where translation for key is defined}
  spec.description   = %q{Find locale files where translation for key is defined}
  spec.homepage      = 'https://github.com/creasty/find_t'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
