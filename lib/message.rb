module Message
  # Class for displaying messages
  class Error
    @at_line = "\nError at line".freeze
    @loc = '==>'.freeze
    class << self
      # Displays error for the current line
      def display_error(toml_file, e_msg)
        line = toml_file.line_number
        var = toml_file.value_arr[2]
        msg = "#{@at_line} #{line}: #{e_msg}\n\t #{@loc} #{var}"
        puts msg
      end

      # Display error for no file
      def no_such_file(message)
        puts message
      end

      # Display error for no argument
      def no_argument(message)
        puts message
      end
    end
  end

  class Info
    class << self
      def display_check(file)
        puts "Checking for errors in #{file.file_name}"
      end

      def display_error_count(toml_file)
        puts "\nNumber of errors found: #{toml_file.error_amount}"
      end
    end
  end
end
