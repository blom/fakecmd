fakecmd
=======

[![Build Status](https://travis-ci.org/blom/fakecmd.png)](https://travis-ci.org/blom/fakecmd)

* [Homepage](https://github.com/blom/fakecmd)
* [Documentation](http://rdoc.info/gems/fakecmd)

Fakes system commands. Intended for use in tests. If your code relies heavily
on system commands and verifies their exit status, you may not want to rely on
the OS to be able to run your tests. That's the basic idea.

Originally inspired by [FakeFS](https://github.com/defunkt/fakefs).

Installation
------------

    gem install fakecmd

Usage
-----

### Require

    require "fakecmd"

### Add some commands

    FakeCmd.add "bar", 0, "pork"
    FakeCmd.add :foo,  1, "chop"
    FakeCmd.add /hat/, 2, "good"

*Command*, *exit status*, and *output*.

#### Everything is a regular expression internally

    "hi"
    :hi
    /hi/

All equal.

### Enable

Faking only happens between `on!` and `off!`, or in a block.

#### `on!` and `off!`

    FakeCmd.on!
    # ...
    FakeCmd.off!

#### Block

    FakeCmd do
      # ...
    end

### Run

#### Using the examples above

    `bar mitzva`   # => "pork"
    $?.exitstatus  # => 0

    %x(fool)       # => "chop"
    $?.exitstatus  # => 1

    %x(nice hat)   # => "good"
    $?.exitstatus  # => 2

#### No match

    `nope`        # => false
    $?.exitstatus # => 127

### Which calls are faked

    ``
    %x

For now.

### Clear the collection

    FakeCmd.clear!

A simple example
----------------

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
