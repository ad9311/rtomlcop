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
      def comment?(toml_file)
        Comment::Oneline.space?(toml_file) if toml_file.line_arr.all?(@rgx_comment)
      end

      # Check line has a key with an unclosed string as a value
      def string?(toml_file)
        Key::KeyString.closed?(toml_file) if toml_file.line_arr.all?(@rgx_string)
      end

      # Check line is a key with a numeric value
      def int?(toml_file)
        Key::KeyInt.padding?(toml_file) if toml_file.line_arr.all?(@rgx_int)
        Key::KeyInt.valid_value?(toml_file) if toml_file.line_arr.all?(@rgx_int)
      end
    end
  end
end
