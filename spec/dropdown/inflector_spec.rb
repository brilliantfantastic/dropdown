require_relative '../../lib/dropdown/inflector'

describe Dropdown::Inflector do
  describe '#constant_name' do
    it 'can get a constant name from a symbol' do
      Dropdown::Inflector.new(:test).constant_name.should == 'Test'
    end

    it 'should handle underscores' do
      Dropdown::Inflector.new(:test_this).constant_name.should == 'TestThis'
    end
  end
end
