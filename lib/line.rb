require_relative './comment'
require_relative './key'
require_relative './ultis'

module Line
  class Check
    @rgx_comment = Utils::DetectElement.detect_comment
    @rgx_string = Utils::DetectElement.detect_string
    @rgx_int = Utils::DetectElement.detect_int

    class << self
      # Check if comment has a space between # symbol
      def comment?(toml_file, line)
        Comment::Oneline.space?(toml_file, line) if toml_file.line_arr.all?(@rgx_comment)
      end

      # Check line has a key with an unclosed string as a value
      def string?(toml_file, line)
        Key::KeyString.closed?(toml_file, line) if toml_file.line_arr.all?(@rgx_string)
      end

      # Check line is a key with a numeric value
      def int?(toml_file, line)
        Key::KeyInt.padding?(toml_file, line) if toml_file.line_arr.all?(@rgx_int)
      end
    end
  end
end
