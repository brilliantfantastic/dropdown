require 'tempfile'
require_relative '../../lib/dropdown'

describe Dropdown::MarkdownRenderer do
  before do
    @file = Tempfile.new('markdown')
    @file.write "This is *great*, yo"
    @file.close
  end
  subject { Dropdown::MarkdownRenderer.new }
  after { @file.unlink }

  describe '#render' do
    it 'produces html from a markdown file' do
      result = subject.render @file
      result.should == "<p>This is <em>great</em>, yo</p>\n"
    end
  end

  describe '#output_filename' do
    it 'produces the file name with the correct extension for input file' do
      file = Tempfile.new ['foo', '.md']
      filename = File.basename(file)
      subject.output_filename(file).should == filename.gsub(/\.md/, '.html')
    end
  end
end
