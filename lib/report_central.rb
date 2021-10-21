require_relative '../lib/value_types/value_type'
class ReportCentral
  def initialize
    @report = []
    @value_type = ValueType.new
  end

  def call_insp(line)
    offence_codes = []
    offence_codes << @value_type.insp_value(line)
  end
end
