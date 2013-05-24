require 'tempfile'
require 'pathname'
require_relative '../../spec_helper'
require_relative '../../../lib/dropdown/parsers/header_parser'

describe Dropdown::Parsers::HeaderParser do
  describe '.initialize' do

    context 'raising errors' do
      it 'requires a file' do
        expect {
          Dropdown::Parsers::HeaderParser.new
        }.to raise_error ArgumentError

        expect {
          Dropdown::Parsers::HeaderParser.new(nil)
        }.to raise_error ArgumentError
      end

      it 'requires source file to be either .md or .markdown' do
        file = Tempfile.new ['test', '.rtf']

        expect {
          Dropdown::Parsers::HeaderParser.new(file)
        }.to raise_error ArgumentError

        %w(.md .markdown).each do |ext|
          file = Tempfile.new ['test', ext]
          expect {
            Dropdown::Parsers::HeaderParser.new(file)
          }.to_not raise_error ArgumentError
        end
      end
    end

    context 'setting instance variables' do
      let(:file) { Tempfile.new ['text', '.md'] }

      subject { Dropdown::Parsers::HeaderParser.new(file) }

      it 'sets the file' do
        subject.file.should == file
      end

      it 'defaults the headers to an empty hash' do
        subject.headers.should == {}
      end
    end
  end

  describe '#parse_headers' do
    let(:file) {
      file_path = File.join(File.dirname(__FILE__),
                            '../../fixtures/sample_post.md')
      File.new(file_path, 'r')
    }

    subject { Dropdown::Parsers::HeaderParser.new(file) }

    it 'reads in all lines before the first empty line' do
      subject.parse_headers
      subject.headers.should == {
        title: 'Deep Throat Exposed!',
        author: 'Bob Woodward',
        date: '4/4/1974'
      }
    end
  end
end
