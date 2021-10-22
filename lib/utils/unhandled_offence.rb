class UnhandledOffence
  class << self
    def create(lnum, code)
      return unless code.is_a?(Symbol)

      { lnum: lnum, code: code }
    end
  end
end
