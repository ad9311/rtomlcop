module Message
  class Error
    @at_line = 'Error at line'.freeze
    @loc = 'Check after =>'
    class << self
      def display_error(toml_file, e_message, pos = nil)
        if pos.nil?
          puts "#{@at_line} #{toml_file.line_number}: #{e_message}"
        else
          puts "#{@at_line} #{toml_file.line_number}: #{e_message} #{@loc} #{pos}"
        end
      end
    end
  end
end
