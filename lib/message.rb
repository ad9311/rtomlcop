module Message
  # Class for displaying messages
  class Error
    @loc = '==>'.freeze
    class << self
      # Displays error for the current line
      def display_error(toml_file, e_msg)
        line = toml_file.line_number
        var = toml_file.value_arr[2]
        msg = "\n [#{line}]: #{e_msg}\n\t#{@loc} #{var}"
        puts msg
      end

      def display_comment_error(toml_file, e_msg)
        line = toml_file.line_number
        var = toml_file.value_arr[1]
        msg = "\n [#{line}]: #{e_msg}\n\t#{@loc} #{var}"
        puts msg
      end

      def file_error(message)
        puts message
      end
    end
  end

  class Warning
    class << self
      def no_toml(file_name)
        puts "Warning! \"#{file_name}\" is not a toml file. Program will continue but expect errors."
      end

      def no_files
        puts 'No toml files found.'
      end
    end
  end

  class Info
    @doted_line = ".....................................\n\n".freeze
    class << self
      def display_check(file)
        puts "Searching for errors in #{file}"
      end

      def display_dotted_line
        puts @doted_line
      end

      def display_error_count(file, toml_file)
        puts "\n#{toml_file.error_amount} errors found in #{file}"
      end

      def display_total_errors(toml_file, file)
        puts "Found: #{toml_file.total_errors} errors in #{file} files."
      end
    end
  end
end
