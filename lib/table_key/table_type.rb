require_relative '../utils/codes.rb'
require_relative './array_table_collection.rb'

class TableType
  include Codes::Status
  include Codes::Offence

  def initialize
    @offences = []
    @list = []
  end

  def insp_table(line)
    @list << ArrayTableCollection.new(line) unless line.fetch(:table).nil?
    p @list.last.add_child(line) unless line.fetch(:key).nil?
    [TEST]
  end
end
