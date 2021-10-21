require_relative '../../../utils/codes'
require_relative './bs_utils'
require_relative '../../../utils/offence'

class BasicString
  include Codes::Status
  include BsUtils

  def initialize
    @str = nil
    @lnum = 0
    @last_lnum = 0
    @last_code = OK
  end

  def insp_bs(line)
    incr_bs_lnum(line) if @last_code == OK
    concat_bs(line)
    arr_bs_resp(switch_mlbs(@str))
  end

  private

  def incr_bs_lnum(line)
    @lnum = line.fetch(:lnum)
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

    stack = []
    s_str = chop_ends(str)
    s_str.size.times do |ind|
      lnum_bs_offset(s_str, ind)
      chk = chk_esc_char(s_str, ind, stack.last)
      stack << { ind: @lnum, code: chk } if chk.is_a?(Symbol)
    end
    p stack
    OK
  end

  def lnum_bs_offset(str, ind)
    @lnum += 1 if str[ind] == "\n"
  end
end
