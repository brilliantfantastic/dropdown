require_relative '../../../lib/dropdown/dropbox/access_token'

describe Dropdown::Dropbox::AccessToken do
  describe '.authorize' do
    it 'returns the url for the user to authorize Dropbox' do
      url = Dropdown::Dropbox::AccessToken.authorize 'key', 'secret'
      url.should == 'https://www.dropbox.com/1/oauth2/authorize?client_id=key&response_type=code'
    end
  end
end
