require_relative '../../../utils/codes'
require_relative './bs_utils'
require_relative '../../../utils/offence'

class BasicString
  include Codes::Status
  include BsUtils

  def initialize
    @str = nil
    @last_lnum = nil
    @first_lnum = nil
    @last_code = OK
  end

  def insp_bs(line)
    # incr_bs_lnum(line)
    concat_bs(line)
    resp = arr_bs_resp(switch_mlbs(@str))
    p @last_code
    resp
  end

  private

  def incr_bs_lnum(line)
    ok = @last_code == OK
    return @first_lnum = line.fetch(:lnum) if ok

    @last_lnum = @first_lnum + 1
  end

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

  def arr_bs_resp(resp)
    unless resp.is_a?(Array)
      @last_code = OK unless MULTI.include?(resp)
      return [resp]
    end
    @last_code = OK
    resp
  end

  def mlcode?
    MULTI.include?(@last_code)
  end

  def insp_mlbs(str)
    return OK if empty_mlbs?(str)

    return @last_code = MULTI_BS unless mlbs_closed?(str)

    # stack = []
    # s_str = chop_ends(str)
    # s_str.size.times do |ind|
    #   chk = chk_esc_char(s_str, ind, stack.last)
    #   stack << { ind: ind, code: chk } unless chk.nil?
    # end
    OK
  end
end
