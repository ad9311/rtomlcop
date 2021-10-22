class UnhandledOffence
  attr_reader :unh_offence

  def initialize(lnum, code)
    @lnum = lnum
    @code = code
    @unh_offence = create
  end

  private

  def create
    @unh_offence = { lnum: @lnum, code: @code }
  end
end
