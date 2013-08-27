require_relative '../../spec_helper'
require_relative '../../support/dummy_dropbox'
require_relative '../../../lib/dropdown'
require_relative '../../../lib/dropdown/output_stores/dropbox_store'

describe Dropdown::OutputStores::DropboxStore do
  include DummyDropbox

  let(:access_token) { 'blah' }
  let(:html) { "<p>This is <em>great</em>, yo</p>\n" }
  let(:output_path) { '/blog/processed' }
  before { Dropdown.configure { |c| c.dropbox_access_token = access_token } }
  after { remove_stubbed_dropbox_files }

  subject { Dropdown::OutputStores::DropboxStore.new output_path }

  describe '#save' do
    it 'creates an output directory if it does not exist' do
      filename = 'stuff.html'
      path = File.join(output_path, filename).gsub /^\//, ''
      stub_dropbox_put_file access_token, path, html, true

      subject.save html, filename
      stubbed_dropbox_pathname(subject.path).should exist
    end
  end
end
