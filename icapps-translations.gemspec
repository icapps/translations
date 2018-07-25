# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'icapps/translations/version'

Gem::Specification.new do |spec|
  spec.name          = 'icapps-translations'
  spec.version       = Icapps::Translations::VERSION
  spec.authors       = ['Jelle Vandebeeck']
  spec.email         = ['jelle.vandebeeck@icapps.com']
  spec.summary       = 'Import translations from the icapps translations portal.'
  spec.homepage      = 'https://github.com/icapps/translations'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin/) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)/)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_dependency 'thor', '~> 0.19'
  spec.add_dependency 'colorize', '~> 0.7'
end
