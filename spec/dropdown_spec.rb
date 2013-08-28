require_relative 'spec_helper'
require_relative '../lib/dropdown'

describe Dropdown do
  describe '.configure' do
    it 'sets values' do
      Dropdown.configure do |c|
        c.renderer = :blah
      end
      Dropdown.configuration.renderer.should == :blah
    end
  end
end
