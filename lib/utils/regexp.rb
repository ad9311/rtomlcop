require_relative '../utils/codes'

module RegExp
  include Codes::Status
  include Codes::TypeOf

  module Slices
    TABLE = Regexp.new(/^\[.*\]/).freeze
    KEY = Regexp.new(/.*=(\w\W)*/).freeze
    VALUE = Regexp.new(/(?<==)[\w\W]*/).freeze
    COMMENT = Regexp.new(/^#+.*\n$/).freeze
  end

  module ValueFormat
    QUOTES = Regexp.new(/['"]/).freeze

    def of_type(value)
      type = RegExp::UNDEF
      type_str = string_type(value)
      type = type_str unless type_str.nil?
      type
    end

    def string_type(value)
      return RegExp::STR if QUOTES.match?(value)
    end
  end

  module NumericValue
    HEX_4 = Regexp.new(/[0-9a-fA-F]{4}$/).freeze
    HEX_8 = Regexp.new(/[0-9a-fA-F]{8}$/).freeze
  end

  module StringValue
    # String Type
    # Basic String
    BSSRT = Regexp.new(/^"{1,}/).freeze
    BSEND = Regexp.new(/"{1,}(\n?)$/).freeze

    # Literal String
    LSSRT = Regexp.new(/^'{1,}/).freeze
    LSEND = Regexp.new(/'{1,}(\n?)$/).freeze

    # Basic Strings
    MLBSSRT = Regexp.new(/^"{3,}/).freeze
    MLBSEND = Regexp.new(/"{3,}(\n?)$/).freeze
    CLMLBS = Regexp.new(/^"{6}(\n?)$/).freeze
    CLSLBS = Regexp.new(/^"{2}(\n?)$/).freeze

    # Literal Strings
    MLLSSRT = Regexp.new(/^'{3,}/).freeze
    MLLSEND = Regexp.new(/'{3,}(\n?)$/).freeze
  end
end
