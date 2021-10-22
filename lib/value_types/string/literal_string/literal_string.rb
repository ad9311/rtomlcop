require_relative '../../../utils/codes'
require_relative './ls_utils'
require_relative '../../../utils/unhandled_offence'

class LiteralString
  include Codes::Status
  include LSUtils

  def initialize
    @str = nil
    @lnum = 0
    @last_code = OK
  end

  def insp_ls(line)
    incr_ls_lnum(line) if @last_code == OK
    concat_ls(line)
    arr_ls_resp(switch_mlls(@str))
  end

  private

  def incr_ls_lnum(line)
    @lnum = line.fetch(:lnum)
  end

  def concat_ls(line)
    @str = line.fetch(:value) unless MULTI.include?(@last_code)
    return unless MULTI.include?(@last_code)

    str = line.fetch(:self)
    @str.concat(str)
  end

  def switch_mlls(str)
    con = mlls?(str)
    @last_code = MULTI_LS if con
    case con || mllscode?
    when true
      mlls(str)
    else
      :SLLS
    end
  end

  def arr_ls_resp(resp)
    unless resp.is_a?(Array)
      @last_code = OK unless MULTI.include?(resp)
      return [resp]
    end
    @last_code = OK
    resp
  end

  def mllscode?
    MULTI.include?(@last_code)
  end

  def lnum_ls_offset(str, ind)
    @lnum += 1 if str[ind] == "\n"
  end

  def mlls(str)
    return OK if empty_mlls?(str)

    return @last_code = MULTI_LS unless mlls_closed?(str)

    insp_mlls(str)
  end

  def insp_mlls(str)
    s_str = mlls_chop_ends(str)
    s_str.size.times do |ind|
      lnum_ls_offset(s_str, ind)
      quote = mlls_valid_quote(s_str, ind)
      return UnhandledOffence.create(@lnum, quote) unless quote.nil?
    end
    OK
  end
end
