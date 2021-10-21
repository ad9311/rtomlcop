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
end
