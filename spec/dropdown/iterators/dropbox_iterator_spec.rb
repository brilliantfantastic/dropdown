require 'webmock/rspec'
require_relative '../../../lib/dropdown'
require_relative '../../../lib/dropdown/iterators/dropbox_iterator'

describe Dropdown::Iterators::DropboxIterator do
  describe '.initialize' do
    it 'should require a source path' do
      expect{ Dropdown::Iterators::DropboxIterator.new(nil) }.to raise_error ArgumentError
    end
  end

  describe '.each' do
    it 'should iterate over markdown files that end in .md' do
      Dropdown.configure { |c| c.dropbox_access_token = 'blah' }
      dir = '/Documents/test'
      path = '/Documents/test/test1.md'

      body = {
        contents: [{
          is_dir: false,
          path: path
          }]
      }.to_json

      stub_request(:get, "https://api.dropbox.com/1/metadata/auto#{dir}?file_limit=25000&include_deleted=false&list=true").
        with(:headers => {'Authorization'=>"Bearer blah"}).
        to_return(:status => 200, :body => body)

      expect{ |f| Dropdown::Iterators::DropboxIterator.new(dir).each(&f) }.to yield_with_args path
    end
  end
end
