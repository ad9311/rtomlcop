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

  def insp_tblkey(_line)
    [SKIP]
  end
end
