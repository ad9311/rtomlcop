class MajorOffence < ::StandardError
  attr_reader :offence

  def initialize(lnum, code)
    super()
    @lnum = lnum
    @code = code
    @offence = create
  end

  private

  def create
    @offence = { lnum: @lnum, code: @code }
  end
end
