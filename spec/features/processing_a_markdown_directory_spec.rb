require_relative '../spec_helper'
require_relative '../support/dummy_dropbox'
require_relative '../../lib/dropdown'

describe 'Processing a directory of markdown files' do
  subject { Dropdown::Processor.new }

  context 'in a local directory' do

    let(:current_directory) { File.expand_path File.dirname(__FILE__) }
    let(:blog_directory) { File.join current_directory, '../fixtures/blog' }
    let(:html_directory) { File.join(blog_directory, 'html') }

    after { FileUtils.rm_rf("#{html_directory}") }

    it 'generates the html files for the markdown files' do
      subject.source = blog_directory
      subject.output_store = Dropdown::OutputStores::FileStore.new(html_directory)
      subject.renderer = :markdown_renderer
      subject.process

      html_files = Dir[File.join(html_directory, '**', '*')]
      html_files.length.should be > 0
    end

  end

  context 'for a Dropbox directory' do
    include DummyDropbox

    let(:access_token) { 'blah' }
    let(:blog_directory) { 'blog' }
    let(:html_directory) { 'blog/processed' }

    before { Dropdown.configure { |c| c.dropbox_access_token = access_token } }
    after { remove_stubbed_dropbox_files }

    it 'generates the html files for the markdown files' do
      markdown_file = "#{blog_directory}/my-trip-to-africa.md"
      html_file = "#{html_directory}/my-trip-to-africa.html"
      contents =  "THIS HAS BEEN PROCESSED"
      stub_dropbox_metadata access_token, blog_directory, [{is_dir: false, path: markdown_file}]

      stub_dropbox_put_file access_token, html_file, contents, true
      stub_dropbox_get_file access_token, markdown_file

      subject.source = blog_directory
      subject.output_store = Dropdown::OutputStores::DropboxStore.new(html_directory)
      subject.markdown_iterator = Dropdown::Iterators::DropboxIterator.new(blog_directory)
      subject.reader = Dropdown::Readers::DropboxReader.new
      subject.renderer = :markdown_renderer
      subject.process

      output_file = stubbed_dropbox_pathname(html_file)
      File.exists?(output_file).should be_true
    end
  end
end
