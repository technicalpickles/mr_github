# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mr_github/version'

Gem::Specification.new do |gem|
  gem.name          = "mr_github"
  gem.version       = MrGithub::VERSION
  gem.authors       = ["Josh Nichols"]
  gem.email         = ["josh@technicalpickles.com"]
  gem.description   = %q{A tool to make it easy to clone and pull all your GitHub repositories}
  gem.summary       = %q{A tool to make it easy to clone and pull all your GitHub repositories}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency "ghee"
  gem.add_dependency "dotenv"
  gem.add_dependency "thor"
end
