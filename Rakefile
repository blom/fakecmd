require "rubygems"
require "bundler"
Bundler.setup(:default)

require "mg"
require "rake/clean"
require "spec/rake/spectask"
require "yard"

CLOBBER.include(".yardoc", "Gemfile.lock", "doc")
MG.new("fakecmd.gemspec")

task :default => :spec

Spec::Rake::SpecTask.new :spec do |t|
  t.libs       = %w(lib spec)
  t.spec_files = Dir["spec/**/*_spec.rb"]
  t.spec_opts  = %w(--color)
  t.rcov       = true
  t.rcov_opts  = %w(-x ^/,spec -t --sort coverage)
end

YARD::Rake::YardocTask.new :yard do |t|
  t.files   = %w(lib/**/*.rb - LICENSE)
  t.options = %w(-mmarkdown -rREADME.md -odoc)
end
