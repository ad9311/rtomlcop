require_relative '../utils/segments'
require_relative '../utils/codes'
require_relative '../offence/major_offence'
require_relative './table_type'

class TableKeyType
  include Segmemts
  include Codes::Status
  include Codes::Offence

  def initialize
    @offences = []
    @tbl = TableType.new
  end

  def insp_tblkey(line)
    tbl = @tbl.insp_table(line)
    [*tbl]
  end
end
