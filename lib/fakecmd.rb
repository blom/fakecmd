require "set"

module FakeCmd
  module_function

  module VERSION
    MAJOR = 0
    MINOR = 0
    PATCH = 0

    def self.to_s
      [MAJOR, MINOR, PATCH] * "."
    end
  end

  def on!
    Kernel.class_eval do
      alias_method :fakecmd_backquote, :`

      def `(cmd)
        FakeCmd.process_command(cmd)
      end
    end
  end

  def off!
    Kernel.class_eval do
      alias_method :`, :fakecmd_backquote
      remove_method :fakecmd_backquote
    end
  end

  def clear!
    commands.clear
  end

  def commands
    @_commands ||= Set.new
  end

  def process_command(cmd)
    commands.each do |h|
      if cmd[h[:regexp]]
        fakecmd_backquote("(exit #{h[:status]})")
        return h[:output]
      end
    end
    fakecmd_backquote("(exit 127)")
  end

  def add(cmd, status = 0, output = "", &block)
    commands << {
      :regexp => Regexp.new(cmd.to_s),
      :output => block ? block.call : output,
      :status => status
    }
  end
end

def FakeCmd
  FakeCmd.on!
  yield
ensure
  FakeCmd.off!
end
