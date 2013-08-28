require_relative '../../spec_helper'
require_relative '../../../lib/dropdown/readers'

describe Dropdown::Readers::ReaderFactory do
  it 'creates a reader with a type' do
    reader = Dropdown::Readers::ReaderFactory.create :dropbox
    reader.should be_a Dropdown::Readers::DropboxReader
  end
end
