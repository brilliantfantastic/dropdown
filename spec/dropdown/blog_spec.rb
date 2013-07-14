require_relative '../spec_helper'
require_relative '../../lib/dropdown'

describe Dropdown::Blog do
  it 'can be initialized with a source directory' do
    directory = 'foo'
    blog = Dropdown::Blog.new directory
    blog.source.should == directory
  end
end
