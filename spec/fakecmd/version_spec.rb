require "spec_helper"

describe FakeCmd, "::VERSION" do
  let(:major) { FakeCmd::VERSION::MAJOR }
  let(:minor) { FakeCmd::VERSION::MINOR }
  let(:patch) { FakeCmd::VERSION::PATCH }

  describe :to_s do
    subject { FakeCmd::VERSION.to_s }
    specify { should == "#{major}.#{minor}.#{patch}" }
  end

  describe(:MAJOR) { specify { major.should be_a Fixnum } }
  describe(:MINOR) { specify { minor.should be_a Fixnum } }
  describe(:PATCH) { specify { patch.should be_a Fixnum } }
end
