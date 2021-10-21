class Offence
  class << self
    def gen(lnum, code)
      { lnum: lnum, code: code }
    end
  end
end
