require_relative '../../../utils/codes'
require_relative './bs_utils'

class BasicString
  include Codes::Status
  include BsUtils

  def initialize
    @str = nil
    @last_code = OK
  end

  def insp_bs(line)
    concat_bs(line)
    arr_resp(switch_mlbs(@str))
  end

  private

  def concat_bs(line)
    @str = line.fetch(:value) unless MULTI.include?(@last_code)
    return unless MULTI.include?(@last_code)

    str = line.fetch(:self)
    @str.concat(str)
  end

  def switch_mlbs(str)
    con = mlbs?(str)
    @last_code = MULTI_BS if con
    case con || mlcode?
    when true
      insp_mlbs(str)
    else
      'Single Line'
    end
  end

  def arr_resp(resp)
    return [resp] unless resp.is_a?(Array)

    resp
  end

  def mlcode?
    MULTI.include?(@last_code)
  end

  def insp_mlbs(str)
    return OK if empty_mlbs?(str)

    return @last_code = MULTI_BS unless mlbs_closed?(str)

    # stack = []
    # resp = []
    # s_str = chop_ends(str)
    # s_str.size.times do |ind|
    #   chk = chk_esc_char(s_str, ind, stack.last)
    #   resp << chk unless chk.nil?
    # end
    OK
  end
end
