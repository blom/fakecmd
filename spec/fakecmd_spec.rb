require "spec_helper"

describe FakeCmd do
  describe :add do
    it "should add the given command" do
      keys = [:regexp, :status, :output]
      args = [/foo/, 5, "..."]
      FakeCmd.add *args
      FakeCmd.commands.should == Set.new([Hash[keys.zip args]])
    end
  end

  describe :clear! do
    before { FakeCmd.add :foo }

    it "should call clear on commands" do
      FakeCmd.commands.should_receive(:clear).once.and_return(Set.new)
      FakeCmd.clear!
    end

    it "should clear commands" do
      FakeCmd.commands.size.should_not be 0
      FakeCmd.clear!
      FakeCmd.commands.size.should be 0
    end
  end

  describe :commands do
    before { FakeCmd.add :foo }
    subject { FakeCmd.commands }
    specify { should be_a Set }
    its(:size) { should be 1 }
  end

  describe :process_command do
    [:foo, "foo", /foo/].each do |command|
      context "commands containing #{command.inspect}" do
        it 'should match command "foo"' do
          output = rand(100**100).to_s
          FakeCmd.add(command, 5, output)
          FakeCmd do
            FakeCmd.process_command("foo").should == output
          end
        end
      end
    end

    context "given a nonexistent command" do
      it "should set the proper exit status" do
        system ""
        es = $?.exitstatus

        FakeCmd { %x() }
        $?.exitstatus.should == es
      end
    end
  end
end

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
