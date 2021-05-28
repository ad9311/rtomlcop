module Message
  # Class for displaying messages
  class Error
    @at_line = "\nError at line".freeze
    @loc = 'Check =>'.freeze
    class << self
      # Displays error for the current line
      def display_error(toml_file, e_message, pos = nil)
        line = toml_file.line_number
        if pos.nil?
          puts " #{@at_line} #{line}: #{e_message}"
        else
          puts " #{@at_line} #{line}: #{e_message}\n\t#{@loc} #{pos}"
        end
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
