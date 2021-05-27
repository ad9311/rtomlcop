module Message
  class Error
    @at_line = 'Error at line'.freeze
    @loc = 'Check =>'.freeze
    class << self
      def display_error(toml_file, e_message, pos = nil)
        line = toml_file.line_number
        if pos.nil?
          puts " #{@at_line} #{line}: #{e_message}\n\n"
        else
          puts " #{@at_line} #{line}: #{e_message}\n\t#{@loc} #{pos}\n"
        end
      end

      def no_such_file(message)
        puts message
      end

      def no_argument(message)
        puts message
      end
    end
  end

  class Info
    class << self
      def display_check
        puts "Checking for errors...\n\n"
      end

      def display_error_count(toml_file)
        puts "\nNumber of errors found: #{toml_file.error_amount}"
      end
    end
  end
end
