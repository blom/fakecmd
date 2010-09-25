module FakeCmd
  module VERSION
    const_defined?(:MAJOR) || MAJOR = 0
    const_defined?(:MINOR) || MINOR = 0
    const_defined?(:PATCH) || PATCH = 0

    def self.to_s
      [MAJOR, MINOR, PATCH] * "."
    end
  end
end
