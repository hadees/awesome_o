# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'awesome_o/version'

Gem::Specification.new do |gem|
  gem.name          = 'awesome_o'
  gem.version       = AwesomeO::VERSION
  gem.authors       = ['Evan Alter']
  gem.email         = ['evan.alter@gmail.com']
  gem.description   = 'AwesomeO is a frameworke agnostic, redis-backed, shopping cart system'
  gem.summary       = 'Originaly forked from the gem Cartman'
  gem.homepage      = 'http://github.com/hadees/awesome-o'
  gem.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency('redis')

  gem.add_development_dependency('rspec', '~> 3.0.0')
end
