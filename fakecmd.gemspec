require File.expand_path("../lib/fakecmd", __FILE__)

Gem::Specification.new do |spec|
  spec.name        = "fakecmd"
  spec.version     = FakeCmd::VERSION.to_s
  spec.summary     = "Fakes system commands."
  spec.description = "Fakes system commands. Intended for use in tests."
  spec.files       = Dir["[A-Z][A-Z]*", "lib/**/*.rb"]
  spec.author      = "Ørjan Blom"
  spec.email       = "blom@blom.tv"
  spec.homepage    = "http://github.com/blom/fakecmd"

  spec.add_development_dependency "bluecloth"
  spec.add_development_dependency "mg"
  spec.add_development_dependency "rcov"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "yard"
end
