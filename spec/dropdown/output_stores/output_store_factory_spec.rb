require_relative '../../spec_helper'
require_relative '../../../lib/dropdown/output_stores'

describe Dropdown::OutputStores::OutputStoreFactory do
  it 'creates an output store with a type and a path' do
    output_store = Dropdown::OutputStores::OutputStoreFactory.create :dropbox, 'blah'
    output_store.should be_a Dropdown::OutputStores::DropboxStore
  end
end
