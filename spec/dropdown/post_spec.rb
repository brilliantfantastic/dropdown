require_relative '../spec_helper'
require_relative '../../lib/dropdown'

describe Dropdown::Post do
  it 'is initialized with a path to an html file' do
    source = 'foo'
    Dropdown::Post.new(source).source.should == source
  end
end
