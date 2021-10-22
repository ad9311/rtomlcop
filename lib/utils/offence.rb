class Offence
  class << self
    def create(lnum, code)
      { lnum: lnum, code: code }
    end
  end
end
