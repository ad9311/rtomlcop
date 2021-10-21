require_relative '../utils/regexp'
require_relative '../utils/codes'

class ValueType
  include RegExp::ValueFormat
  include Codes::Status
  include Codes::TypeOf

  def initialize
    @type = nil
    @offence = OK
  end

  def insp_value(line)
    offence = nil
    @type = of_type(line.fetch(:value))
    case @type
    when STR
      offence = 'String Type Here'
    else
      offence = UNDEF
    end
    @offences = offence unless offence.nil?
  end
end
