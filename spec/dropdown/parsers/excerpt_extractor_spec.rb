require_relative '../../spec_helper'
require_relative '../../../lib/dropdown/parsers/parser'
require_relative '../../../lib/dropdown/parsers/excerpt_extractor'

describe Dropdown::Parsers::ExcerptExtractor do
  before do
    @file = mock('file')
    File.should_receive(:extname).and_return '.html'
  end

  subject { Dropdown::Parsers::ExcerptExtractor.new(@file) }

  describe '#extract' do
    it 'extracts the first 120 characters' do
      @file.should_receive(:readlines).and_return ['Hello world']
      subject.extract.should == 'Hello world'
    end
  end
end
