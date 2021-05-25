module Comment
  class Comment
    class << self
      def check_comment(comment, file_line)
        CommentHandler.check_whitespace(comment)
      rescue CommentHandler::NoWhitespaceError => e
        puts "Error at line #{file_line}: #{e.message}"
      end
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
