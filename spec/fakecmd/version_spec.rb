require "spec_helper"

describe FakeCmd, "::VERSION" do
  let(:ver) { FakeCmd::VERSION }

  describe ".to_s" do
    subject { ver.to_s }
    specify { should == "#{ver::MAJOR}.#{ver::MINOR}.#{ver::PATCH}" }
  end

  describe("::MAJOR") { specify { ver::MAJOR.should be_a Fixnum } }
  describe("::MINOR") { specify { ver::MINOR.should be_a Fixnum } }
  describe("::PATCH") { specify { ver::PATCH.should be_a Fixnum } }
end
