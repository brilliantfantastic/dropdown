require 'fakeweb'

module DummyDropbox
  def self.included(base)
    FakeWeb.allow_net_connect = false
  end

  def stub_dropbox_token(key, secret, access_token, uid="12345")
    body = { access_token: access_token, token_type: "bearer", uid: uid }

    FakeWeb.register_uri(:post, "https://#{key}:#{secret}@api.dropbox.com/1/oauth2/token",
                         :status => 200,
                         :body => body.to_json)
  end

  def stub_dropbox_metadata(access_token, directory, contents)
    body = { contents: contents }

    FakeWeb.register_uri(:get, "https://api.dropbox.com/1/metadata/auto#{directory}?file_limit=25000&include_deleted=false&list=true",
                         :authorization => "Bearer #{access_token}",
                         :status => 200,
                         :body => body.to_json)
  end

  def stub_dropbox_put_file(access_token, path, contents, overwrite=false)
    body = {
      size: "#{contents.length / 100}KB",
      bytes: contents.length,
      is_dir: false,
      path: path
    }

    FakeWeb.register_uri(:put, "https://api-content.dropbox.com/1/files_put/auto/#{path}?overwrite=#{overwrite}",
                         :status => 200,
                         :content_type => "application/octet-stream",
                         :body => body.to_json)
  end
end
