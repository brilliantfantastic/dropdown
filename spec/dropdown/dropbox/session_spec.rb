require_relative '../../../lib/dropdown/dropbox/session'

describe Dropdown::Dropbox::Session do
  describe '#authorize_url' do
    it 'returns the url for the user to authorize Dropbox' do
      session = Dropdown::Dropbox::Session.new 'key', 'secret'
      session.authorize_url.should == 'https://www.dropbox.com/1/oauth2/authorize?client_id=key&response_type=code'
    end
  end
end
