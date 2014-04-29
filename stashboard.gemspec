# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "stashboard/version"

Gem::Specification.new do |s|
  s.name        = "stashboard-ruby"
  s.version     = Stashboard::VERSION
  s.platform    = Gem::Platform::RUBY
  s.date        = '2014-04-29'
  s.authors     = ["Sam Mulube", "Brian Stolz", "Matthew Rayner"]
  s.email       = ["sam@connectedenvironments.com", "brian@tecnobrat.com", "matt@mattrayner.co.uk"]
  s.homepage    = "http://github.com/mattrayner/stashboard-ruby"
  s.summary     = %q{Library for interacting with the Stashboard api. Updated to allow writes with the latest release.}
  s.description = %q{Little library written to make interacting with the stashboard api a bit easier.}

  s.rubygems_version = ">= 1.3.6"

  s.add_dependency('yajl-ruby', '>= 0.8.1')
  s.add_dependency('oauth', '>= 0.4.4')

  s.add_development_dependency('yard', '>= 0.6.4')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
