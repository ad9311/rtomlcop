require_relative '../lib/utils'
require_relative '../lib/message'

module Comment
  class Oneline
    class << self
      attr_accessor :error_pos

      # Method to check for a required space after # in a comment
      def space?(toml_file)
        CommentHandler.check_whitespace(toml_file)
      rescue CommentHandler::NoWhitespaceError => e
        toml_file.new_error
        toml_file.value_arr[1] = toml_file.value_arr[1].slice(1..-1) if toml_file.value_arr[1][0] != '#'
        Message::Error.display_comment_error(toml_file, e.message(@error_pos))
      end
    end

    class CommentHandler
      def self.check_pos(toml_file)
        comment = toml_file.value_arr[1]
        comment = comment.slice(0..2)
        inx = comment.index('#')
        res = nil
        if inx == 1
          res = 'before' if comment[0] != ' '
          res = 'after' if comment[2] != ' '
        elsif comment[1] != ' ' && comment[1] != '#'
          res = 'after'
        end
        res
      end

      # If no space after # ina comment raise an error
      def self.check_whitespace(toml_file)
        res = check_pos(toml_file)
        Oneline.error_pos = res
        raise NoWhitespaceError unless res.nil?
      end

      class NoWhitespaceError < StandardError
        def message(error_pos)
          "Missing whitespace #{error_pos} # symbol in comment."
        end
      end
    end
  end
end
