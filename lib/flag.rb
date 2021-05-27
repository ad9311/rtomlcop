require_relative '../lib/utils'

module Flag
  class Hold
    attr_reader :holder

    def initialize
      @holder = [nil]
    end
  end
end
