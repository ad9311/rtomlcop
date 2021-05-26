module Toml
  class File
    attr_reader :line_number, :line, :line_arr, :doc_arr, :error_amount

    def initialize
      @line_number = 1
      @line = nil
      @line_arr = []
      @doc_arr = []
      @error_amount = 0
    end

    def next_line
      @line_number += 1
    end

    def line_to_arr(line)
      @line = line
      @line_arr = []
      @line_arr << line
      @doc_arr << @line_arr
      @doc_arr
    end

    def new_error
      @error_amount += 1
    end
  end
end
