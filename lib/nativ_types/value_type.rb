require_relative '../utils/regexp'
require_relative '../utils/codes'

class ValueType
  include RegExp::ValueFormat
  include Codes::Status
  include Codes::TypeOf

  def initialize
    @type = nil
    @offences = []
    @last_code = nil
    @multi_codes = %i[]
  end

  def insp_value(line)
    offence = nil
    @type = of_type(line.fetch(:value))
    case @type
    when STR
      code = '...'
      offence = new_offence(line.fetch(:num), code)
    else
      offence = new_offence(line.fetch(:num), UNDEF)
    end
    @offences << offence unless offence.nil?
  end

  private

  def new_offence(num, code)
    @last_code = code
    multi = @multi_codes.include?(@last_code)
    ok = code == OK
    { at_line: num, code: code } unless multi || ok
  end
end
