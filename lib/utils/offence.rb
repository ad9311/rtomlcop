class Offence
  attr_reader :offence

  def initialize(lnum, code)
    @lnum = lnum
    @code = code
    @offence = create
  end

  private

  def create
    @offence = { lnum: @lnum, code: @code }
  end
end
