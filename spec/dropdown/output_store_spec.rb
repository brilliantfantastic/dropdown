require 'pathname'
require 'tmpdir'
require_relative '../spec_helper'
require_relative '../../lib/dropdown/output_store'

describe  Dropdown::OutputStore do
  let(:html) { "<p>This is <em>great</em>, yo</p>\n" }
  let(:output_path) { File.join(Dir.tmpdir, 'foo') }
  subject { Dropdown::OutputStore.new output_path }

  describe '#save' do
    it 'create an output directory if it does not exist' do
      subject.save html, 'stuff.html'
      Pathname.new(subject.path).should exist
    end

    it 'names the output file the same as the input file' do
      subject.save html, 'bar.html'
      output_file = File.join(output_path, 'bar.html')
      File.exists? output_file
    end

    it 'writes the content to the file name' do
      subject.save html, 'bar.html'
      output_file = File.join(output_path, 'bar.html')
      File.readlines(output_file)[0].should == html
    end
  end
end
