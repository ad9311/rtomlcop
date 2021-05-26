module Comment
  class Oneline
    class << self
      def space?(toml_file)
        CommentHandler.check_whitespace(toml_file)
      rescue CommentHandler::NoWhitespaceError => e
        toml_file.new_error
        puts "Error at line #{toml_file.line_number}: #{e.message}"
      end
    end

    class CommentHandler
      class NoWhitespaceError < StandardError
        def message
          'Missing whitespace after #.'
        end
      end

      def self.check_whitespace(toml_file)
        raise NoWhitespaceError unless toml_file.line[0] == '#' && toml_file.line[1] == ' '
      end
    end
  end
end
