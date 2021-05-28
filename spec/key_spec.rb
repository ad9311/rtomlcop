require_relative '../lib/toml_file'
require_relative '../lib/utils'
require_relative '../lib/key'

describe Key do
  let(:toml_file) { Toml::File.new }
  before 'Add new line to toml_file instance' do
    toml_file.line_to_arr('int = asdad #bad comment')
    Utils::Slice.slice_value(toml_file)
    puts Key::KeyString.closed?(toml_file)
  end
  describe Key::KeyString do
    it 'Returns error for unclosed string' do
      expect { :Key::KeyString.closed?(toml_file) }.to raise_error(StandardError)
    end
  end
end
