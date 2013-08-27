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

  describe '#find_html_files' do
    let(:current_directory) { File.expand_path File.dirname(__FILE__) }
    let(:source_directory) { File.join current_directory, '../fixtures/processed' }

    it 'returns all of the html files within a directory' do
      html_files = Dir[File.join(source_directory, '**', '*')]
      subject.find_html_files(source_directory).length.should == html_files.length
    end
  end
end
