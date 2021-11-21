require_relative '../utils/codes'
require_relative './array_table_collection'

class TableType
  include Codes::Status
  include Codes::Offence

  def initialize
    @offences = []
    @list = []
  end

  def insp_table(line)
    insp_nesting(line)
  end

  def insp_nesting(line)
    unless line.fetch(:table).nil?
      @list << ArrayTableCollection.new(line)
      @list.last.insp_collection(@list)
    end
    @list.last.add_child(line) unless line.fetch(:key).nil?
  end
end
