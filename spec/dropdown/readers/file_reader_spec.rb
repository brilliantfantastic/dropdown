require_relative '../../spec_helper'
require_relative '../../../lib/dropdown/readers/file_reader'

describe Dropdown::Readers::FileReader do
  let(:contents) { "This is *great*, yo" }
  subject { Dropdown::Readers::FileReader.new }

  before do
    @file = Tempfile.new(['markdown', '.md'])
    @file.write contents
    @file.close
  end
  after { @file.unlink }

  describe '#read' do
    it 'returns the contents of the file' do
      subject.read(@file.path).should == contents
    end
  end
end
