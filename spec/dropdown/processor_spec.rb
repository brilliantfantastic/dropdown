require_relative '../../lib/dropdown'

describe Dropdown::Processor do
  describe '.process' do
    let(:source) { 'data/home_dir/markdown' }

    it 'loops through each file in a source directory' do
      Dropdown::Processor.new(source).process
    end

    it 'creates a new html file in the destination directory for each file in the source directory'
    it 'stores the title in the index with each new file'

    context 'updating an existing markdown file' do
    end
  end
end
