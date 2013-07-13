require_relative '../spec_helper'
require_relative '../../lib/dropdown'

describe Dropdown::Configuration do
  subject { Dropdown::Configuration.new }
  it 'sets defaults' do
    subject.renderer.should == :markdown_renderer
  end
end
