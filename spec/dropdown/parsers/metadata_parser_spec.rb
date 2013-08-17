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

      it 'requires source file to be .html' do
        file = Tempfile.new ['test', '.rtf']

        expect {
          Dropdown::Parsers::MetadataParser.new(file)
        }.to raise_error Dropdown::FileTypeError

        %w(.html).each do |ext|
          file = Tempfile.new ['test', ext]
          expect {
            Dropdown::Parsers::MetadataParser.new(file)
          }.to_not raise_error Dropdown::FileTypeError
        end
      end
    end

    context 'setting instance variables' do
      let(:file) { Tempfile.new ['text', '.html'] }

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
                            '../../fixtures/processed/my-trip-to-africa.html')
      File.new(file_path, 'r')
    }

    subject { Dropdown::Parsers::MetadataParser.new(file) }
    it 'creates a header variable for each comment line prior to the body' do
      subject.parse
      subject.headers.should == {
        title: 'My trip to Africa',
        author: 'Jane Goodall',
        date: '4/4/1989'
      }
    end
  end
end
