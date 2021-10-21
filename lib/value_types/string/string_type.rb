require_relative '../../utils/codes'
class StringType
  include Codes::Status

  def initialize
    @last_code = OK
  end

  def insp_str(line)
    @last_code = switch_str_type(line)
  end

  private

  def switch_str_type(line)
    case basic_string?(line)
    when true
      :TODO
    else
      :TODO
    end
  end

  def basic_string?(line)
    return true if @last_code == MULTI_BS

    return false if @last_code == MULTI_LS

    first = line.fetch(:value)[0]
    last = line.fetch(:value)[-1, 1]
    double = first == '"' && last != "'"
    return true if double

    false
  end
end
