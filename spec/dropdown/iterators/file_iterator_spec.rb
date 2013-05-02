require_relative '../../../lib/dropdown/iterators/file_iterator'

describe Dropdown::Iterators::FileIterator do
  describe '.initialize' do
    it 'should require a source path'
  end

  describe '.each' do
    it 'should iterate over markdown files that end in .md'
    it 'should iterate over markdown files that end in .markdown'
    it 'should ignore files that are not markdown files'
  end
end

