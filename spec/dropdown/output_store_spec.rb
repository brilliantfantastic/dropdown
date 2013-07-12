require 'pathname'
require 'tmpdir'
require_relative '../../lib/dropdown/output_store'

describe  Dropdown::OutputStore do
  let(:html) { "<p>This is <em>great</em>, yo</p>\n" }
  subject { Dropdown::OutputStore.new Dir.tmpdir }

  describe '#save' do
    it 'should store a file' do
      subject.save html
      Pathname.new(subject.path).should exist
    end

    it 'should not create an output directory if one exists'
    it 'should save the html file in the directory'
  end
end
