require_relative '../../utils/codes'
require_relative '../../utils/regexp'
require_relative './basic_string/basic_string'

class StringType
  include Codes::Status
  include RegExp::StringValue

  def initialize
    @last_code = OK

    @bs = BasicString.new
  end

  def insp_str(line)
    @last_code = switch_str_type(line)
  end

  private

  def switch_str_type(line)
    case basic_string?(line)
    when true
      @bs.insp_bs(line)
    else
      'Literal String'
    end
  end

  def basic_string?(line)
    return true if @last_code == MULTI_BS

    return false if @last_code == MULTI_LS

    str = line.fetch(:value)
    lssrt = LSSRT.match?(str)
    lsend = LSEND.match?(str)
    bssrt = BSSRT.match?(str)
    bsend = BSEND.match?(str)

    return true if bssrt && !lsend

    return true if bsend && !lssrt

    false
  end
end
