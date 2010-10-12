$VERBOSE = nil if RUBY_VERSION["1.8.6"]

require File.expand_path("../../lib/fakecmd", __FILE__)
require "rspec"

RSpec.configure do |config|
  config.before :each do
    FakeCmd.clear!
    FakeCmd.off!
  end
end
