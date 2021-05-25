module TomlFile
  class TomlLine
    attr_reader :line

    def initialize
      @line = 1
    end

    def next_line
      @line += 1
    end
  end
end
