fakecmd
=======

[![Build Status](http://img.shields.io/travis/blom/fakecmd.svg)][travis]
[![Gem Version](http://img.shields.io/gem/v/fakecmd.svg)][gem]

[travis]: https://travis-ci.org/blom/fakecmd
[gem]: http://rubygems.org/gems/fakecmd

* [Homepage](https://github.com/blom/fakecmd)
* [Documentation](http://rubydoc.info/gems/fakecmd)

Fakes system commands. Intended for use in tests. If your code relies on system
commands and perhaps verifies their exit status, you may not want to rely on
the OS to be able to run your tests. Especially so if these commands have side
effects or take a long time to run. Originally inspired by
[FakeFS](https://github.com/defunkt/fakefs).

Example
-------

    module Users
      def self.count
        c = %x(users).split.size
        c if $?.exitstatus == 0
      end
    end

    class UsersTest < Test::Unit::TestCase
      def setup
        FakeCmd.clear!
      end

      def test_count_success
        FakeCmd.add :users, 0, "a b c"
        assert_equal 3, FakeCmd { Users.count }
        assert_equal 0, $?.exitstatus
      end

      def test_count_failure
        FakeCmd.add :users, 1
        assert_nil FakeCmd { Users.count }
        assert_equal 1, $?.exitstatus
      end
    end

* `FakeCmd.clear!` clears the current collection of faked commands, if any.

* `FakeCmd.add :users, 0, "a b c"` fakes the `users` command, defines its exit
  status to be 0, and its output to be `a b c`. `:users` could have been a
  string or regular expression as well; internally, everything is a regular
  expression.

* `FakeCmd { Users.count }` calls `Users.count` in the faked environment. You
  can also use `FakeCmd.on!` and `FakeCmd.off!` to turn it on and off,
  respectively. No system command using the backtick or `%x` notation will be
  executed in the block or between `.on!` and `.off!`. `system ""` will be
  executed if the command is not found in the collection.

* `$?.exitstatus` reflects the exit status given to `.add`.

Keep in mind that only the following calls will be faked:

    ``
    %x

Installation
------------

    gem install fakecmd
