require 'date'
require_relative '../../utils/codes'
require_relative '../../utils/patterns'
require_relative '../../offence/minor_offence'

class DateType
  include Codes::Status
  include Codes::Offence

  def initialize
    @dtt = nil
    @lnum = 0
    @offences = nil
  end

  def insp_dtt(line)
    @offences = nil
    dtt_set(line)
    arr_dtt_resp(parse_dtt)
  end

  private

  def dtt_set(line)
    @lnum = line.fetch(:lnum)
    @dtt = line.fetch(:value)
  end

  def arr_dtt_resp(resp)
    case resp
    when Array
      resp
    else
      [resp]
    end
  end

  def parse_dtt
    DateTime.jisx0301(@dtt)
    send_dtt_offnc
  rescue Date::Error
    space = @dtt.include?(' ')
    return @offences = MinorOffence.new(@lnum, INV_DTT_FRMT) unless space

    ind = @dtt.index(' ')
    dtt = @dtt.chars
    dtt[ind] = 'T'
    @dtt = dtt.join
    retry
  end

  def send_dtt_offnc
    return @offences unless @offences.nil?

    OK
  end
end
