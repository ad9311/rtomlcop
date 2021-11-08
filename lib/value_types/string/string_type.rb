require_relative '../../utils/codes'
require_relative '../../utils/patterns'
require_relative './basic_string/basic_string'
require_relative './literal_string/literal_string'

class StringType
  include Codes::Status
  include Patterns::StringValue

  def initialize
    @last_code = OK

    @bs = BasicString.new
    @ls = LiteralString.new
  end

  def insp_str(line)
    resp = switch_str_type(line)
    @last_code = resp.last
    resp
  end

  private

  def switch_str_type(line)
    case basic_string?(line)
    when true
      @bs.insp_bs(line)
    else
      @ls.insp_ls(line)
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
