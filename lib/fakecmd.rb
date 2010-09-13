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
    unless @enabled
      @enabled = true
      Kernel.class_eval do
        alias_method :fakecmd_backquote, :`
        def `(cmd)
          FakeCmd.process_command(cmd)
        end
      end
      true
    end
  end

  def off!
    if @enabled
      @enabled = false
      Kernel.class_eval do
        alias_method :`, :fakecmd_backquote
        remove_method :fakecmd_backquote
      end
      true
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
    system ""
  end

  def add(cmd, status = 0, output = "", &block)
    cmd = cmd.to_s if cmd.is_a?(Symbol)
    commands << {
      :regexp => Regexp.new(cmd),
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
