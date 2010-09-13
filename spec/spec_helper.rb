if RUBY_VERSION.to_f > 1.8
  require "simplecov"
  SimpleCov.start
end

require "fakecmd"

Spec::Runner.configure do |config|
  config.before :each do
    FakeCmd.clear!
    FakeCmd.off!
  end
end
