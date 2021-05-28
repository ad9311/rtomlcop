require_relative '../lib/utils'
require_relative '../lib/message'

module Comment
  class Oneline
    class << self
      # Method to check for a required space after # in a comment
      def space?(toml_file)
        CommentHandler.check_whitespace(toml_file)
      rescue CommentHandler::NoWhitespaceError => e
        toml_file.new_error
        # comment = '#'
        # comment.concat(toml_file.value_arr[1])
        # Message::Error.display_error(toml_file, e.message, comment) # Calls message if an error has been raised
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
          'Missing whitespace after #.'
        end
      end
    end
  end
end
