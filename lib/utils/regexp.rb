module RegExp
  module Slices
    TABLE = Regexp.new(/^\[.*\]/).freeze
    KEY = Regexp.new(/.*=(\w\W)*/).freeze
    VALUE = Regexp.new(/(?<==)[\w\W]*/).freeze
    COMMENT = Regexp.new(/^#+.*\n$/).freeze
  end
end
