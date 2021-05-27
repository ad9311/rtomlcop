require_relative '../lib/message'

module Flag
  class Arg
    attr_reader :file_path

    def initialize(file_path)
      @file_path = file_path
    end

    class << self
      def get_files(arg)
        raise InvalidFile if File.exist?(arg)
      end
    end

    class InvalidFile < Errno::EISDIR
      def message
        'File does not exits!'
      end
    end
  end
end
