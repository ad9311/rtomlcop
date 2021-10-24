require_relative '../utils/segments'
require_relative '../utils/patterns'
require_relative '../utils/codes'
require_relative './string/string_type'
require_relative './numeric/numeric_type'
require_relative './date/date_type'
require_relative './other/other_type'

class ValueType
  include Segmemts
  include Patterns::ValueFormat
  include Codes::Status
  include Codes::TypeOf

  def initialize
    @type = nil
    @last_code = OK

    @str = StringType.new
    @num = NumericType.new
    @dtt = DateType.new
    @otr = OtherType.new
  end

  def insp_value(line)
    @type = of_type(line.fetch(:value)) unless on_multi?(@last_code)
    resp = switch_type(line, @type)
    @last_code = resp.last
    resp
  end

  private

  def switch_type(line, type)
    case type
    when STR
      @str.insp_str(line)
    when NUM
      @num.insp_num(line)
    when DTT
      @dtt.insp_dtt(line)
    else
      @otr.insp_otr(line)
    end
  end

  def on_multi?(last_code)
    MULTI.include?(last_code)
  end
end
