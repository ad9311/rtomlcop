require_relative '../../utils/patterns'
require_relative './float/float_type'
require_relative './integer/integer_type'

class NumericType
  include Patterns::ValueFormat
  include Patterns::NumericValue

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
    return true if num.count('.').positive?

    return !INTPREFIX.match?(num) && /[eE]/.match?(num)
  end
end
