require_relative '../../spec_helper'
require_relative '../../support/dummy_dropbox'
require_relative '../../../lib/dropdown'
require_relative '../../../lib/dropdown/readers/dropbox_reader'

describe Dropdown::Readers::DropboxReader do
  include DummyDropbox

  let(:access_token) { 'blah' }
  let(:path) { 'blog/stuff.md' }
  let(:contents) { "This is *great*, yo" }
  subject { Dropdown::Readers::DropboxReader.new }

  before do
    Dropdown.configure { |c| c.dropbox_access_token = access_token }
    stub_dropbox_put_file access_token, path, contents, true
  end
  after { remove_stubbed_dropbox_files }

  describe '#read' do
    it 'returns the contents of the file' do
      stub_dropbox_get_file access_token, path
      subject.read(path).should == contents
    end
  end
end
