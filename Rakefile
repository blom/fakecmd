require "rubygems"
require "bundler"
Bundler.setup(:default)

require "mg"
require "rake/clean"
require "spec/rake/spectask"
require "yard"

CLOBBER.include(".yardoc", "coverage", "doc")
MG.new("fakecmd.gemspec")

task :default => :spec

Spec::Rake::SpecTask.new :spec do |t|
  t.libs       = %w(lib spec)
  t.spec_files = Dir["spec/**/*_spec.rb"]
  t.spec_opts  = %w(--color)
  if RUBY_VERSION.to_f < 1.9
    t.rcov, t.rcov_opts = true, %w(-x ^/,spec -t --sort coverage)
  end
end

YARD::Rake::YardocTask.new :yard do |t|
  t.files   = %w(lib/**/*.rb - LICENSE)
  t.options = %w(-mmarkdown -rREADME.md -odoc)
end
