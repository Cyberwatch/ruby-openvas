# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'openvas/version'

Gem::Specification.new do |s|
  s.name        = 'openvas'
  s.version     = Openvas::VERSION
  s.date        = '2017-12-25'
  s.summary     = 'Openvas API Client (OMP 7.0)'
  s.description = 'Easily interface with the Openvas for consuming results'
  s.authors     = ['Florian Wininger']
  s.email       = 'fw.centrale@gmail.com'
  s.homepage    = 'https://github.com/Cyberwatch/ruby-openvas'

  s.license       = 'MIT'

  s.require_paths = ['lib']
  s.files         = `git ls-files -z`.split("\x0")
  # s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'webmock'
end
