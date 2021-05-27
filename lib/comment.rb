require_relative '../lib/utils'
require_relative '../lib/message'

module Comment
  class Oneline
    class << self
      def space?(toml_file)
        CommentHandler.check_whitespace(toml_file)
      rescue CommentHandler::NoWhitespaceError => e
        toml_file.new_error
        Message::Error.display_error(toml_file, e.message)
      end
    end

    class CommentHandler
      @rgx_no_ws = Utils::Error.no_white_space

      def self.check_whitespace(toml_file)
        unless toml_file.value_arr[1].nil?
          
          raise NoWhitespaceError if toml_file.value_arr[1][0] != ' '
        end
      end

      class NoWhitespaceError < StandardError
        def message
          'Missing whitespace after #.'
        end
      end
    end
  end
end
