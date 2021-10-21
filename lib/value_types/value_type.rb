require_relative '../utils/regexp'
require_relative '../utils/codes'
require_relative './string/string_type'

class ValueType
  include RegExp::ValueFormat
  include Codes::Status
  include Codes::TypeOf

  def initialize
    @type = nil
    @last_code = OK
  end

  def insp_value(line)
    @type = of_type(line.fetch(:value)) unless on_multi?(@last_code)
    @last_code = switch_type(line, @type)
  end

  def switch_type(line, type)
    case type
    when STR
      str = StringType.new
      str.insp_str(line)
    else
      UNDEF
    end
  end

  def on_multi?(last_code)
    MULTI.include?(last_code)
  end
end
