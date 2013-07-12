describe 'Processing a directory of markdown files' do
  context 'in a local directory' do

    let(:blog_directory) { } # Fixtured directory of md
    let(:html_directory_path) { } # Path to ideal directory location

    subject { Dropdown::Processor.new }

    it 'generates the html files for the markdown files' do
      subject.source = blog_directory
      subject.markdown_iterator = Dropdown::Iterators::FileIterator.new
      subject.output_store = Dropdown::OutputStore.new(html_directory_path)
      subject.process

      # Make sure that all the markdown files have accompianyied
    end

  end
end
