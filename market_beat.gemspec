# Copyright (c) 2011 Michael Dvorkin
#
# Market Beat is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
require "rake"
require File.dirname(__FILE__) + "/lib/market_beat/version"

task :default => :spec

task :spec do
  # Run plain rspec command without RSpec::Core::RakeTask overrides.
  exec "rspec -c spec"
end

Gem::Specification.new do |s|
  s.name        = "market_beat"
  s.version     = MarketBeat.version
# s.platform    = Gem::Platform::RUBY
  s.authors     = "Michael Dvorkin"
  s.date        = Time.now.strftime("%Y-%m-%d")
  s.email       = "mike@dvorkin.net"
  s.homepage    = "http://github.com/michaeldv/market_beat"
  s.summary     = "Fetch up-to-date stock quotes and 100+ financial and market indicators."
  s.description = "Fetch real-time and delayed stock quotes and 100+ other financial and market indicaors from publicly available sources."

  s.rubyforge_project = "market_beat"

  s.files         = Rake::FileList["[A-Z]*", "lib/**/*.rb", "lib/**/*.yml", "spec/*", ".gitignore"]
  s.test_files    = Rake::FileList["spec/*"]
  s.executables   = []
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec", ">= 2.6.0"
end
