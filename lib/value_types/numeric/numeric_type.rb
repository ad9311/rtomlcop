require_relative '../../utils/regexp'
require_relative './float/float_type'
require_relative './integer/integer_type'

class NumericType
  include RegExp::ValueFormat
  include RegExp::NumericValue

  def initialize
    @flt = FloatType.new
    @int = IntegerType.new
  end

  def insp_num(line)
    switch_num_type(line)
  end

  private

  def switch_num_type(line)
    case float?(line)
    when true
      @flt.insp_float(line)
    else
      @int.insp_int(line)
    end
  end

  def float?(line)
    num = line.fetch(:value)
    point = num.count('.').positive?
    esp_char = ESPFLT.include?(num)
    (point && !INTPREFIX.match(num)) || esp_char
  end
end
