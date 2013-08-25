require 'webmock/rspec'
require_relative '../../spec_helper'
require_relative '../../../lib/dropdown/dropbox/session'

describe Dropdown::Dropbox::Session do
  subject { Dropdown::Dropbox::Session.new 'key', 'secret' }

  describe '#authorize_url' do
    it 'returns the url for the user to authorize Dropbox' do
      subject.authorize_url.should == 'https://www.dropbox.com/1/oauth2/authorize?client_id=key&response_type=code'
    end
  end

  describe '#access_token' do
    it 'returns the access token based on the authorize code' do
      code = "blah"
      access_token = "12345678"

      stub_request(:post, "https://key:secret@api.dropbox.com/1/oauth2/token").
        with(:body => {"code"=>"#{code}", "grant_type"=>"authorization_code"}).
        to_return(:status => 200, :body => {access_token: access_token, token_type: "bearer", uid: "12345"}.to_json)

      subject.access_token(code).should == access_token
    end
  end
end
