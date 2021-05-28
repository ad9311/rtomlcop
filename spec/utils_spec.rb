require_relative '../lib/toml_file'
require_relative '../lib/utils'

# Test for int
describe Utils do
  let(:toml_file) { Toml::File.new }
  before 'Add new line to toml_file instance' do
    toml_file.line_to_arr('int = 10t0 #bad comment')
    Utils::Slice.slice_value(toml_file)
    Utils::Slice.get_comment(toml_file)
    Utils::Slice.get_var_name(toml_file)
  end
  describe Utils::Slice do
    it 'Return value from line' do
      expect(toml_file.value_arr[0]).to eq('10t0')
    end
    it 'Returns the comment without the #' do
      expect(toml_file.value_arr[1]).to eq('bad comment')
    end
    it 'Returns the variable name' do
      expect(toml_file.value_arr[2]).to include('int')
    end
    it 'Returns the bad character in the inter value' do
      expect(Utils::Slice.get_bad_int(toml_file)).to eq('t')
    end
  end
end

describe Utils do
  let(:toml_file) { Toml::File.new }
  before 'Add new line to toml_file instance' do
    toml_file.line_to_arr('float = 10e2k')
    Utils::Slice.slice_value(toml_file)
    Utils::Slice.get_value(toml_file)
    Utils::Error.invalid_float(toml_file)
  end
  describe Utils::Slice do
    it '...' do
      expect(toml_file.value_arr[0]).to eq('10e2k')
    end
    it 'Raise error from invalid float' do
      expect(Utils::Error.invalid_float(toml_file)).to be_instance_of(ArgumentError)
    end
  end
end