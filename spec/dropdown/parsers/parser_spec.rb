require 'tempfile'
require_relative '../../spec_helper'
require_relative '../../../lib/dropdown/parsers/parser'

class MyParser
  include Dropdown::Parsers::Parser
end

describe Dropdown::Parsers::Parser do
  context 'raising errors' do
    it 'requires a file' do
      expect {
          MyParser.new(nil)
        }.to raise_error ArgumentError
    end

    it 'requires source file to be .html' do
      file = Tempfile.new ['test', '.rtf']

      expect {
        MyParser.new(file)
      }.to raise_error Dropdown::FileTypeError

      %w(.html).each do |ext|
        file = Tempfile.new ['test', ext]
        expect {
          MyParser.new(file)
        }.to_not raise_error Dropdown::FileTypeError
      end
    end
  end

  context 'setting instance variables' do
    let(:file) { Tempfile.new ['text', '.html'] }

    subject { MyParser.new(file) }

    it 'sets the file' do
      subject.file.should == file
    end
  end
end
