require_relative '../../../utils/codes'
require_relative '../../../utils/regexp'
require_relative '../../../offence/minor_offence'

class IntegerType
  include Codes::Status
  include Codes::Offence
  include RegExp::NumericValue
  include RegExp::ValueFormat

  def initialize
    @num = nil
    @lnum = 0
    @offences = []
  end

  def insp_int(line)
    @offences = []
    int_set(line)
    arr_int_resp(parse_int)
  end

  private

  def int_set(line)
    @lnum = line.fetch(:lnum)
    @num = line.fetch(:value)
  end

  def arr_int_resp(resp)
    case resp
    when Array
      resp
    else
      [resp]
    end
  end

  def parse_int
    @offences << MinorOffence.new(@lnum, LEADZERO) if lead_zero?
    valid_int
    send_int_offnc
  end

  def lead_zero?
    return false if @num == '0'

    return unless NUMBER.match?(@num[1])

    @num[0] == '0' && !INTPREFIX.match?(@num[1])
  end

  def valid_int
    Integer(@num)
  rescue ArgumentError
    @offences << MinorOffence.new(@lnum, INV_INT_FRMT)
  end

  def send_int_offnc
    return @offences unless @offences.empty?

    OK
  end
end
