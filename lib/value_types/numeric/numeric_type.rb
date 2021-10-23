require_relative './float/float_type'
require_relative '../../utils/regexp'

class NumericType
  include RegExp::ValueFormat
  include RegExp::NumericValue

  def initialize
    @flt = FloatType.new
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
      [:integer]
    end
  end

  def float?(line)
    num = line.fetch(:value)
    point = num.count('.').positive?
    esp_char = ESPFLT.include?(num)
    exp_flt = EXPFLT.match?(num)
    point || esp_char || exp_flt
  end
end
