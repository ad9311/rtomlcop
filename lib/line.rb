require_relative './comment'
require_relative './key'
require_relative './utils'

module Line
  class Check
    class << self
      # Check if comment has a space between # symbol
      def comment?(toml_file)
        Utils::Slice.get_comment(toml_file)
        Comment::Oneline.space?(toml_file)
      end

      # Check line has a key with an unclosed string as a value
      # Ignore if line is a comment
      def string?(toml_file)
        toml_file.value_arr[4] = Utils::Slice.slice_value(toml_file)
        Key::KeyString.closed?(toml_file)
      end

      # Check line is a key with a integer value
      # Ignore if line is a comment
      def numeric?(toml_file)
        value = Utils::Slice.get_value(toml_file)
        case value
        when 'float'
          Key::KeyFloat.valid?(toml_file)
        when 'int'
          Key::KeyInt.valid?(toml_file)
        when 'date_time'
          Key::KeyDate.valid?(toml_file)
        end
      end
    end
  end
end
