require "set"
require File.expand_path("../fakecmd/version", __FILE__)

module FakeCmd
  module_function

  def add(cmd, status = 0, output = "", &block)
    cmd = cmd.to_s if cmd.is_a?(Symbol)
    commands << {
      :regexp => Regexp.new(cmd),
      :output => block ? block.call : output,
      :status => status
    }
  end

  def clear!
    commands.clear
  end

  def commands
    @_commands ||= Set.new
  end

  def on?
    Kernel.private_methods.map(&:to_sym).include?(:fakecmd_backquote)
  end

  def off!
    if on?
      Kernel.class_eval do
        alias_method :`, :fakecmd_backquote
        remove_method :fakecmd_backquote
      end
      true
    end
  end

  def on!
    unless on?
      Kernel.class_eval do
        alias_method :fakecmd_backquote, :`
        def `(cmd)
          FakeCmd.process_command(cmd)
        end
      end
      true
    end
  end

  def process_command(cmd)
    commands.each do |h|
      if cmd[h[:regexp]]
        fakecmd_backquote("(exit #{h[:status]})")
        return h[:output]
      end
    end
    system "__nonexistent__"
  end
end

def FakeCmd
  FakeCmd.on!
  yield
ensure
  FakeCmd.off!
end
