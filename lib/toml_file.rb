# Dedicated class for toml files
module Toml
  class File
    attr_reader :line_number, :line, :line_arr, :error_amount, :total_errors
    attr_accessor :value_arr

    def initialize
      @line_number = 1
      @line = nil
      @line_arr = []
      @error_amount = 0
      @total_errors = 0
      @value_arr = [nil, nil, nil, nil]
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

    def add_errors
      @total_errors += @error_amount
    end

    def clear
      @line_number = 1
      @line = nil
      @line_arr = []
      @error_amount = 0
      @value_arr = [nil, nil, nil, nil]
    end
  end
end
