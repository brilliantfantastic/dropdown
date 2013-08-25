require 'webmock/rspec'

module DummyDropbox
  def stub_dropbox_metadata(access_token, directory, contents)
    body = { contents: contents }
    stub_request(:get, "https://api.dropbox.com/1/metadata/auto#{directory}?file_limit=25000&include_deleted=false&list=true").
      with(:headers => {'Authorization'=>"Bearer #{access_token}"}).
      to_return(:status => 200, :body => body.to_json)
  end
end
