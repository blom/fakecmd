require File.expand_path("../../lib/fakecmd", __FILE__)

Spec::Runner.configure do |config|
  config.before :each do
    FakeCmd.clear!
    FakeCmd.off!
  end
end
