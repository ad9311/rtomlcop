require_relative './value_types/value_type'
require_relative './utils/codes'

class ReportCentral
  include Codes::Status
  attr_reader :report

  def initialize
    @report = []
    @last_code = OK

    @value_type = ValueType.new
  end

  def call_insp(line)
    for_value(line)
    @report
  end

  private

  def for_value(line)
    code = @value_type.insp_value(line)
    on_multi = MULTI.include?(code)
    if on_multi
      @last_code = code
      return
    end

    offence = new_offence(line, code)
    @report << offence unless offence.nil?
  end

  def new_offence(line, code)
    @last_code = code
    ok = code == OK
    { at: line.fetch(:num), code: code } unless ok
  end
end
