require_relative '../../utils/codes'
require_relative '../../utils/patterns'
require_relative '../../offence/minor_offence'

class OtherType
  include Codes::Status
  include Codes::Offence
  include Patterns::ValueFormat

  def initialize
    @otr = nil
    @lnum = 0
    @offences = nil
  end

  def insp_otr(line)
    @offences = nil
    otr_set(line)
    arr_otr_resp(parse_otr)
  end

  private

  def otr_set(line)
    @lnum = line.fetch(:lnum)
    return @otr = line.fetch(:value) unless line.fetch(:value).nil?

    @otr = line.fetch(:self)
  end

  def parse_otr
    return OK if BOOLTYPE.include?(@otr) || @otr == "\n"

    MinorOffence.new(@lnum, UNDEF)
  end

  def arr_otr_resp(resp)
    case resp
    when Array
      resp
    else
      [resp]
    end
  end
end
