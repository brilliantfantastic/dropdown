require 'tempfile'
require_relative '../../spec_helper'
require_relative '../../../lib/dropdown/parsers/metadata_parser'

describe Dropdown::Parsers::MetadataParser do
  describe '.initialize' do

    context 'raising errors' do
      it 'requires a file' do
        expect {
          Dropdown::Parsers::MetadataParser.new(nil)
        }.to raise_error ArgumentError
      end

      it 'requires source file to be either .md or .markdown' do
        file = Tempfile.new ['test', '.rtf']

        expect {
          Dropdown::Parsers::MetadataParser.new(file)
        }.to raise_error Dropdown::FileTypeError

        %w(.md .markdown).each do |ext|
          file = Tempfile.new ['test', ext]
          expect {
            Dropdown::Parsers::MetadataParser.new(file)
          }.to_not raise_error Dropdown::FileTypeError
        end
      end
    end

    context 'setting instance variables' do
      let(:file) { Tempfile.new ['text', '.md'] }

      subject { Dropdown::Parsers::MetadataParser.new(file) }

      it 'sets the file' do
        subject.file.should == file
      end

      it 'defaults the headers to an empty hash' do
        subject.headers.should == {}
      end
    end
  end

  describe '#parse' do
    let(:file) {
      file_path = File.join(File.dirname(__FILE__),
                            '../../fixtures/sample_post.md')
      File.new(file_path, 'r')
    }

    subject { Dropdown::Parsers::MetadataParser.new(file) }

    it 'creates a header variable for each line prior to first empty line' do
      subject.parse
      subject.headers.should == {
        title: 'Deep Throat Exposed!',
        author: 'Bob Woodward',
        date: '4/4/1974'
      }
    end
  end
end
