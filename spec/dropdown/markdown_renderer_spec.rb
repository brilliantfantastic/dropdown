require 'tempfile'
require_relative '../../lib/dropdown'

describe Dropdown::MarkdownRenderer do
  before do
    @file = Tempfile.new('markdown')
    @file.write "This is *great*, yo"
    @file.close
  end
  after { @file.unlink }

  describe '.render' do
    it 'produces html from a markdown file' do
      renderer = Dropdown::MarkdownRenderer.new
      result = renderer.render @file
      result.should == "<p>This is <em>great</em>, yo</p>\n"
    end
  end
end
