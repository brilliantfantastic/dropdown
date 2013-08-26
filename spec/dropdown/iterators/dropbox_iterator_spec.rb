require_relative '../../spec_helper'
require_relative '../../support/dummy_dropbox'
require_relative '../../../lib/dropdown'

describe Dropdown::Iterators::DropboxIterator do
  describe '.initialize' do
    it 'should require a source path' do
      expect{ Dropdown::Iterators::DropboxIterator.new(nil) }.to raise_error ArgumentError
    end
  end

  describe '.each' do
    include DummyDropbox

    let(:access_token) { 'blah' }
    let(:dir) { '/Documents/test' }
    before { Dropdown.configure { |c| c.dropbox_access_token = access_token } }

    it 'should iterate over markdown files that end in .md' do
      path = '/Documents/test/test1.md'
      contents = [{is_dir: false, path: path}]
      stub_dropbox_metadata access_token, dir, contents

      expect{ |f| Dropdown::Iterators::DropboxIterator.new(dir).each(&f) }.to yield_with_args path
    end

    it 'should iterate over markdown files that end in .markdown' do
      path = '/Documents/test/test1.markdown'
      contents = [{is_dir: false, path: path}]
      stub_dropbox_metadata access_token, dir, contents

      expect{ |f| Dropdown::Iterators::DropboxIterator.new(dir).each(&f) }.to yield_with_args path
    end

    it 'should ignore files that are not markdown files' do
      path = '/Documents/test/test1.txt'
      contents = [{is_dir: false, path: path}]
      stub_dropbox_metadata access_token, dir, contents

      expect{ |f| Dropdown::Iterators::DropboxIterator.new(dir).each(&f) }.not_to yield_control
    end

    it 'should handle an extra slash in the source' do
      directory = dir + "/"

      path = '/Documents/test/test1.markdown'
      contents = [{is_dir: false, path: path}]
      stub_dropbox_metadata access_token, dir, contents

      expect{ |f| Dropdown::Iterators::DropboxIterator.new(directory).each(&f) }.to yield_with_args path
    end
  end
end
