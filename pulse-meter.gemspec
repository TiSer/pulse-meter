# -*- encoding: utf-8 -*-
require File.expand_path('../lib/pulse-meter/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ilya Averyanov", "Sergey Averyanov"]
  gem.email         = ["av@fun-box.ru", "averyanov@gmail.com"]
  gem.description   = %q{Lightweight metrics processor}
  gem.summary       = %q{Lightweight Redis-based metrics
            aggregator and processor with CLI and simple and customizable WEB interfaces}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "pulse-meter"
  gem.require_paths = ["lib"]
  gem.version       = PulseMeter::VERSION

  gem.add_runtime_dependency('gon-sinatra')
  gem.add_runtime_dependency('haml')
  gem.add_runtime_dependency('json')
  gem.add_runtime_dependency('redis')
  gem.add_runtime_dependency('sinatra')
  gem.add_runtime_dependency('terminal-table')
  gem.add_runtime_dependency('eventmachine')
  gem.add_runtime_dependency('thor')

  gem.add_development_dependency('foreman')
  gem.add_development_dependency('mock_redis')
  gem.add_development_dependency('rack-test')
  gem.add_development_dependency('rake')
  gem.add_development_dependency('redcarpet')
  gem.add_development_dependency('rspec')
  gem.add_development_dependency('timecop')
  gem.add_development_dependency('yard')

end
