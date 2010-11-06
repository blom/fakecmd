module FakeCmd
  module VERSION
    MAJOR = 0
    MINOR = 0
    PATCH = 2

    def self.to_s
      [MAJOR, MINOR, PATCH] * "."
    end
  end
end
