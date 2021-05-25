module Comment
  class Comment
    class << self
      def check_comment(comment)
       # CommentHandler.check_whitespace(comment)
        begin
          CommentHandler.check_whitespace(comment)
        rescue CommentHandler::NoWhitespaceError => e
          puts e.message
        end
      end
    end
  end

  class CommentHandler
    class NoWhitespaceError < StandardError
      def message
        'No whitespace detected on comment'
      end
    end

    def self.check_whitespace(comment)
      raise NoWhitespaceError unless comment[0] == '#' && comment[1] == ' '
    end
  end
end
