# coding: utf-8

require File.expand_path("../lib/fakecmd/version", __FILE__)

Gem::Specification.new do |spec|
  spec.name        = "fakecmd"
  spec.version     = FakeCmd::VERSION.to_s
  spec.summary     = "Fakes system commands."
  spec.description = "Fakes system commands. Intended for use in tests."
  spec.license     = "ISC"
  spec.files       = Dir["[A-Z][A-Z]*", "lib/**/*.rb"]
  spec.author      = "Ørjan Blom"
  spec.email       = "blom@blom.tv"
  spec.homepage    = "https://github.com/blom/fakecmd"

  spec.add_development_dependency "kramdown"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "yard"
end
