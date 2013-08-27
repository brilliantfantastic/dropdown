require_relative '../../spec_helper'
require_relative '../../support/dummy_dropbox'
require_relative '../../../lib/dropdown/dropbox/session'

describe Dropdown::Dropbox::Session do
  subject { Dropdown::Dropbox::Session.new 'key', 'secret' }

  describe '#authorize_url' do
    it 'returns the url for the user to authorize Dropbox' do
      subject.authorize_url.should == 'https://www.dropbox.com/1/oauth2/authorize?client_id=key&response_type=code'
    end
  end

  describe '#access_token' do
    include DummyDropbox

    it 'returns the access token based on the authorize code' do
      access_token = "12345678"

      stub_dropbox_token 'key', 'secret', access_token
      subject.access_token('blah').should == access_token
    end
  end
end
