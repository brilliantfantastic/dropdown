require_relative '../spec_helper'
require_relative '../../lib/dropdown'

describe Dropdown::Blog do
  it 'can be initialized with a source directory' do
    directory = 'foo'
    blog = Dropdown::Blog.new directory
    blog.source.should == directory
  end

  describe '#name' do
    it 'can be set from an attribribute' do
      blog = Dropdown::Blog.new
      blog.name = 'Personal'
      blog.name.should == 'Personal'
    end
  end

  describe 'in a local directory' do
    describe '#posts' do
      let(:current_directory) { File.expand_path File.dirname(__FILE__) }
      let(:source_directory) { File.join current_directory, '../fixtures/processed' }

      it 'is initialized to empty' do
        Dropdown::Blog.new.posts.should be_empty
      end

      it 'creates a post for each file in the source' do
        html_files = Dir[File.join(source_directory, '**', '*')]
        blog = Dropdown::Blog.new source_directory
        blog.posts.length.should == html_files.length
      end
    end
  end
end
