require_relative '../lib/utils'
require_relative '../lib/message'

module Comment
  class Oneline
    class << self
      def append_hashtag(toml_file)
        hashtag = '#'
        comment = toml_file.value_arr[1]
        hashtag.concat(comment)
        toml_file.value_arr[1] = hashtag
      end

      # Method to check for a required space after # in a comment
      def space?(toml_file)
        CommentHandler.check_whitespace(toml_file)
      rescue CommentHandler::NoWhitespaceError => e
        toml_file.new_error
        append_hashtag(toml_file)
        Message::Error.display_comment_error(toml_file, e.message)
      end
    end

    class CommentHandler
      @rgx_no_ws = Utils::Error.no_white_space

      # If no space after # ina comment raise an error
      def self.check_whitespace(toml_file)
        return if toml_file.value_arr[1].nil?
        raise NoWhitespaceError if toml_file.value_arr[1][0] != ' '
      end

      class NoWhitespaceError < StandardError
        def message
          'Missing whitespace in comment.'
        end
      end
    end
  end
end
