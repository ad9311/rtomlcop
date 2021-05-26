require_relative '../lib/utils'

module Flag
  class Hold
    attr_reader :is_comment

    def initialize
      @is_comment = false
      @rgx_comment = Utils::Element.detect_comment
    end

    def skip_comment?(toml_file)
      @is_comment = toml_file.line_arr.all?(@rgx_comment)
    end
  end
end
