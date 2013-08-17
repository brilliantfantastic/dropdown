require 'tempfile'
require_relative '../../spec_helper'
require_relative '../../../lib/dropdown/parsers/parser'
require_relative '../../../lib/dropdown/parsers/metadata_parser'

describe Dropdown::Parsers::MetadataParser do
  describe '.initialize' do

    context 'setting instance variables' do
      let(:file) { Tempfile.new ['text', '.html'] }

      subject { Dropdown::Parsers::MetadataParser.new(file) }

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
