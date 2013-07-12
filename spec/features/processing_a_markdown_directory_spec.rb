require_relative '../../lib/dropdown'

describe 'Processing a directory of markdown files' do
  context 'in a local directory' do

    let(:blog_directory) { '../fixtures/blog' }
    let(:html_directory_path) { File.join(blog_directory, 'html') }

    subject { Dropdown::Processor.new }

    it 'generates the html files for the markdown files' do
      subject.source = blog_directory
      subject.output_store = Dropdown::OutputStore.new(html_directory_path)
      subject.renderer = :markdown_renderer
      subject.process

      html_files = Dir[File.join(html_directory_path, '**', '*')]
      html_files.length.should be > 0
    end

  end
end
