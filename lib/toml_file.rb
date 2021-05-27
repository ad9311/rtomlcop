module Toml
  class File
    attr_reader :line_number, :line, :line_arr, :error_amount
    attr_accessor :line_value, :line_comment, :value_arr

    def initialize
      @line_number = 1
      @line = nil
      @line_arr = []
      @line_value = nil
      @line_comment = nil
      @value_arr = [nil, nil]
      @error_amount = 0
    end

    def next_line
      @line_number += 1
    end

    def line_to_arr(line)
      @line = line
      @line_arr << line
    end

    def new_error
      @error_amount += 1
    end
  end
end
