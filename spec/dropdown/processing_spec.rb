require_relative '../../lib/dropdown'

describe Dropdown::Processing do
  describe '.process' do
    it 'loops through each file in a source directory'
    it 'creates a new html file in the destination directory for each file in the source directory'
    it 'stores the title in the index with each new file'

    context 'updating an existing markdown file' do
    end
  end
end
