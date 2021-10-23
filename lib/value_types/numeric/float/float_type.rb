require_relative '../../../utils/codes'
require_relative '../../../utils/regexp'
require_relative '../../../offence/minor_offence'

class FloatType
  include Codes::Status
  include Codes::Offence
  include RegExp::NumericValue
  include RegExp::ValueFormat

  def initialize
    @num = nil
    @lnum = 0
    @offences = []
  end

  def insp_float(line)
    @offences = []
    flt_set(line)
    arr_flt_resp(parse_flt)
  end

  private

  def flt_set(line)
    @lnum = line.fetch(:lnum)
    @num = line.fetch(:value)
  end

  def arr_flt_resp(resp)
    case resp
    when Array
      resp
    else
      [resp]
    end
  end\

  def parse_flt
    return OK if ESPFLT.include?(@num)

    lead_num = NUMBER.match?(@num[0])
    @offences << MinorOffence.new(@lnum, MSS_LEAD_NUM) unless lead_num
    zeros = ZEROS.match?(@num)
    @offences << MinorOffence.new(@lnum, EXT_ZEROS) if zeros
    valid_flt
    send_flt_offnc
  end

  def valid_flt
    Float(@num)
  rescue ArgumentError
    @offences << MinorOffence.new(@lnum, INV_FLT_FRMT)
  end

  def send_flt_offnc
    return @offences unless @offences.empty?

    OK
  end
end
