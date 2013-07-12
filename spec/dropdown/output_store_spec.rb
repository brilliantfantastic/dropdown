require 'pathname'
require 'tmpdir'
require_relative '../../lib/dropdown/output_store'

describe  Dropdown::OutputStore do
  let(:html) { "<p>This is <em>great</em>, yo</p>\n" }
  let(:output_path) { File.join(Dir.tmpdir, 'foo') }
  subject { Dropdown::OutputStore.new output_path }

  describe '#save' do
    it 'create an output directory if it does not exist' do
      subject.save html
      Pathname.new(subject.path).should exist
    end

    it 'names the output file the same as the input file'
    it 'saves the html file in the directory'
  end
end
