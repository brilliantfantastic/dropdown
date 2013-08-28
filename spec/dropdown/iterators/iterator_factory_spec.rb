require_relative '../../spec_helper'
require_relative '../../../lib/dropdown/iterators'

describe Dropdown::Iterators::IteratorFactory do
  it 'creates an iterator with a type and a source' do
    iterator = Dropdown::Iterators::IteratorFactory.create :file, 'blah'
    iterator.should be_a Dropdown::Iterators::FileIterator
  end
end

