require 'colorized_string'

module Message
  # Class for displaying messages
  class Error
    @loc = '==>'.freeze
    class << self
      # Displays error for the current line
      def display_error(toml_file, e_msg)
        line = "\n [#{toml_file.line_number}]: "
        var = toml_file.value_arr[2].to_s
        print ColorizedString[line.to_s].blue
        print "#{e_msg}\n"
        print ColorizedString["\t#{@loc} "].yellow
        puts ColorizedString[var.to_s].red
      end

      def display_comment_error(toml_file, e_msg)
        line = "\n [#{toml_file.line_number}]: "
        var = toml_file.value_arr[1].to_s
        print ColorizedString[line.to_s].blue
        print "#{e_msg}\n"
        print ColorizedString["\t#{@loc} "].yellow
        puts ColorizedString[var.to_s].red
      end

      def file_error(message)
        puts ColorizedString[message.to_s].red
      end
    end
  end

  class Warning
    class << self
      def no_toml(file_name)
        # puts "Warning! \"#{file_name}\" is not a toml file. Program will continue but expect errors."
        print ColorizedString["\nWarning! "].yellow.on_black
        print ColorizedString["\"#{file_name}\" "].red.on_black
        print ColorizedString["is not a toml file. Program will continue but expect errors.\n"].yellow.on_black
      end

      def no_files
        puts ColorizedString['No files with .toml extension found.'].red
      end
    end
  end

  class Info
    class << self
      def display_check(file)
        search = "Now searching in #{file}"
        line = ''
        search.length.times do
          line += '-'
        end
        puts "\n#{line}"
        puts ColorizedString[search.to_s].yellow
        puts line
      end

      def display_error_count(file, toml_file)
        if toml_file.error_amount.zero?
          print ColorizedString["\n #{toml_file.error_amount} errors found in "].green
        else
          print ColorizedString["\n #{toml_file.error_amount} errors found in "].red
        end
        print ColorizedString["\"#{file}\" \n"].blue
      end

      def display_total_errors(toml_file, file)
        final = "Found #{toml_file.total_errors} errors in #{file} file(s).\n"
        line = ''
        final.length.times do
          line += '-'
        end
        puts "\n#{line}"
        if toml_file.total_errors.zero?
          print ColorizedString[final.to_s].green
        else
          print ColorizedString[final.to_s].red
        end
        puts line
      end
    end
  end
end
