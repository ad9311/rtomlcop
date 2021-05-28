require_relative '../lib/toml_file'
require_relative '../lib/utils'

describe 'RTomlCop' do
  let(:toml_file) { Toml::File.new } # initialized a new toml_file instance
  let(:rgx_comment) { Utils::Element.detect_comment } # Regexr to detect comments
  let(:rgx_string) { Utils::Element.detect_string } # Regex to detect double quoted strings
  let(:rgx_num) { Utils::Element.detect_numeric } # Regex to detect numeric values (integers, floats & dates)

  before 'Adds a new line to toml_file instance' do
    toml_file.line_to_arr('int = 100 # this is a int')
    toml_file.next_line # Increments line
  end
  describe Toml::File do
    it 'Is a toml_file instance' do
      expect(toml_file).to be_instance_of(Toml::File)
    end
    it 'Has a new line' do
      expect(toml_file.line).to eq('int = 100 # this is a int')
    end
    it 'Array is 1 unit size' do
      expect(toml_file.line_arr.length).to eq(1)
    end
    it 'Line is number 2' do
      expect(toml_file.line_number).to eq(2)
    end
    it 'Throws error for un only readable variable' do
      expect { toml_file.error_amount = 3 }.to raise_error(NoMethodError)
    end
  end

  describe 'Matching Regexs' do
    it 'Returns true for comment' do
      expect(rgx_comment.match?(toml_file.line)).to eq(true)
    end
    it 'Returns false for no string' do
      expect(rgx_string.match?(toml_file.line)).to eq(false)
    end
    it 'Returns true for numeric' do
      expect(rgx_num.match?(toml_file.line)).to eq(true)
    end
  end
end
