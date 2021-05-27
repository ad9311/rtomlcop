module Toml
  class File
    attr_reader :line_number, :line, :line_arr, :error_amount
    attr_accessor :value_arr

    def initialize
      @line_number = 1
      @line = nil
      @line_arr = []
      # value_arr hold data regarding the current analized line.
      # index 0 holds the varible numeric value
      # index 1 holds comment line
      # index 2 holds variable name
      # index 3 holds type of variable
      @value_arr = [nil, nil, nil, nil]
      @error_amount = 0
    end

    # Increments number line
    def next_line
      @line_number += 1
    end

    # Saves current line string into toml_file instance
    def line_to_arr(line)
      @line = line
      @line_arr << line
    end

    # Counts errors found
    def new_error
      @error_amount += 1
    end
  end
end
