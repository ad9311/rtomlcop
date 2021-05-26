module Comment
  class Oneline
    class << self
      def space?(toml_file, comment)
        CommentHandler.check_whitespace(comment)
      rescue CommentHandler::NoWhitespaceError => e
        puts "Error at line #{toml_file.line_number}: #{e.message}"
        toml_file.new_error
      end
    end

    class CommentHandler
      class NoWhitespaceError < StandardError
        def message
          'Missing whitespace after #.'
        end
      end

      def self.check_whitespace(comment)
        raise NoWhitespaceError unless comment[0] == '#' && comment[1] == ' '
      end
    end
  end
end
