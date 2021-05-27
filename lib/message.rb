module Message
  class Error
    @at_line = 'Error at line'.freeze
    @loc = 'Check =>'
    class << self
      def display_error(toml_file, e_message, pos = nil)
        if pos.nil?
          puts " #{@at_line} #{toml_file.line_number}: #{e_message}"
        else
          puts " #{@at_line} #{toml_file.line_number}: #{e_message} #{@loc} #{pos}"
        end
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
