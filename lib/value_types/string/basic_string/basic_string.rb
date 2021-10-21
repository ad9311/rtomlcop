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
    p mlbs?(@str)
    :ML
  end

  private

  def concat_bs(line)
    @str = line.fetch(:value) unless MULTI.include?(@last_code)
    return unless MULTI.include?(@last_code)

    str = line.fetch(:self)
    @str.concat(str)
  end
end
