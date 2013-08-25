require_relative '../spec_helper'
require_relative '../../lib/dropdown'

describe 'Processing a directory of markdown files' do
  context 'in a local directory' do

    let(:current_directory) { File.expand_path File.dirname(__FILE__) }
    let(:blog_directory) { File.join current_directory, '../fixtures/blog' }
    let(:html_directory) { File.join(blog_directory, 'html') }

    subject { Dropdown::Processor.new }

    after { FileUtils.rm_rf("#{html_directory}") }

    it 'generates the html files for the markdown files' do
      subject.source = blog_directory
      subject.output_store = Dropdown::OutputStore.new(html_directory)
      subject.renderer = :markdown_renderer
      subject.process

      html_files = Dir[File.join(html_directory, '**', '*')]
      html_files.length.should be > 0
    end

  end
end
