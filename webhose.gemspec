# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'webhose/version'

Gem::Specification.new do |gem|
  gem.name        = "webhose"
  gem.summary     = "Lightweight api for webhose.io"
  gem.description = "Lightweight api for webhose.io using faraday http driver"
  gem.licenses    = ['MIT']
  gem.homepage    = "http://github.com/77agency/webhose"
  gem.version     = Webhose::VERSION

  gem.authors     = ["Andrea Piana"]
  gem.email       = "andrea.maria.piana@gmail.com"

  gem.require_paths  = ["lib"]
  gem.files          = `git ls-files`.split("\n")
  gem.test_files     = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables    = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  gem.extra_rdoc_files = ["readme.md"]
  gem.rdoc_options     = ["--line-numbers", "--inline-source", "--title", "Webhose"]

  gem.add_runtime_dependency("faraday")
  gem.add_runtime_dependency("faraday_middleware")
end
