require_relative './value_types/value_type'
require_relative './utils/codes'

class ReportCentral
  include Codes::Status

  def initialize
    @report = []
    @last_code = OK
  end

  def call_insp(line)
    for_value(line)
  end

  def for_value(line)
    value_type = ValueType.new
    code = value_type.insp_value(line)
    on_multi = MULTI.include?(code)
    return if on_multi

    offence = new_offence(line, code)
    @report << offence
  end

  def new_offence(line, code)
    @last_code = code
    ok = code == OK
    { at: line.fetch(:num), code: code } unless ok
  end
end
