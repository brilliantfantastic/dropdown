require 'fakeweb'

module DummyDropbox
  class << self
    attr_accessor :dropbox_base_path
  end

  def self.included(base)
    FakeWeb.allow_net_connect = false
    @dropbox_base_path = File.join Dir.tmpdir, 'dropbox'
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
    FileUtils.mkdir_p(stubbed_dropbox_pathname(path).dirname)
    File.open(stubbed_dropbox_path(path), 'w+') { |f| f.write contents }
  end

  def stubbed_dropbox_pathname(path)
    Pathname.new stubbed_dropbox_path(path)
  end

  def stubbed_dropbox_path(path)
    File.join DummyDropbox.dropbox_base_path, path
  end

  def remove_stubbed_dropbox_files
    FileUtils.rm_rf DummyDropbox.dropbox_base_path
  end
end
