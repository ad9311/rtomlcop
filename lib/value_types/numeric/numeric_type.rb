require_relative './float/float_type'
require_relative '../../utils/regexp'

class NumericType
  include RegExp::ValueFormat

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
    num.count('.').positive? || ESPFLT.include?(num)
  end
end
