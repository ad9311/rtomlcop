require_relative '../utils/segments'
require_relative '../utils/codes'
require_relative '../offence/major_offence'

class TableKeyType
  include Segmemts
  include Codes::Status
  include Codes::Offence

  def initialize
    @lnum = 0
    @offences = []
  end

  def insp_tblkey(line)
    switch_tbl_key_type(line)
  end

  private

  def switch_tbl_key_type(line)
    case table?(line)
    when true
      [:TABLE]
    else
      [:KEY]
    end
  end

  def table?(line)
    return true if line.fetch(:key).nil?

    false
  end
end
