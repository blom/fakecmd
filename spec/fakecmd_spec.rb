require "spec_helper"

describe FakeCmd do
  describe :add do
    before do
      @hash = { :regexp => /foo/, :status => 5, :output => "..." }
      FakeCmd.add @hash[:regexp], @hash[:status], @hash[:output]
    end

    it "should add commands" do
      FakeCmd.commands.size.should be 1
      FakeCmd.commands.to_a.first.should == @hash
    end
  end

  describe :clear! do
    describe :commands do
      it "should receive clear" do
        FakeCmd.commands.should_receive(:clear).
          exactly(:once).and_return(Set.new)
        FakeCmd.clear!
      end
    end

    it "should empty the commands collection" do
      FakeCmd.add :foo
      FakeCmd.commands.size.should be 1
      FakeCmd.clear!
      FakeCmd.commands.size.should be 0
    end
  end

  describe :commands do
    subject { FakeCmd.commands }
    specify { should be_a Set }
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

  describe :@@enabled do
    let(:enabled) { FakeCmd.send(:class_variable_get, :@@enabled) }

    context "calling on!" do
      before { FakeCmd.on! }
      specify { enabled.should be true }
    end

    context "calling off!" do
      before { FakeCmd.off! }
      specify { enabled.should be false }
    end
  end
end
