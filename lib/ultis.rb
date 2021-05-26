module Utils
  class DetectElement
    # attr_reader :value_is_string, :is_comment
    @is_comment = Regexp.new('^(\s+|)#.+.')
    @is_string = Regexp.new('[a-z0-9]+[\s=]+"+.+')
    @is_int = Regexp.new('.+=\s+[0-9]+')

    class << self
      def detect_comment
        @is_comment
      end

      def detect_string
        @is_string
      end

      def detect_int
        @is_int
      end
    end
  end

  class DetectError
    @unclosed = Regexp.new('[a-z0-9]+[\s=]+"+.+"$')
    @padded = Regexp.new('.+=\s+0+[0-9]+')
    class << self
      def unclosed_string
        @unclosed
      end

      def padded_int
        @padded
      end
    end
  end
end
