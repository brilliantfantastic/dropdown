require_relative '../spec_helper'
require_relative '../../lib/dropdown'

describe Dropdown::Blog do
  it 'can be initialized with a source directory' do
    directory = 'foo'
    blog = Dropdown::Blog.new directory
    blog.source.should == directory
  end

  describe '#posts' do
    it 'is initialized to empty' do
      Dropdown::Blog.new.posts.should be_empty
    end
  end
end
