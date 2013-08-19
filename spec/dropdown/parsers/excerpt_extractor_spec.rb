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

    it 'extracts only the html content' do
      @file.should_receive(:readlines).and_return ['<p>Hello world</p>']
      subject.extract.should == 'Hello world'
    end

    it 'extracts multiple lines' do
      @file.should_receive(:readlines).and_return [
        '<p>Hello world</p>',
        '<div>I hope the world is fine</div>'
      ]
      subject.extract.should == "Hello world\nI hope the world is fine"
    end

    it 'ignores comments' do
      @file.should_receive(:readlines).and_return [
        '<!-- This should be ignored -->',
        '<p>Hello world</p>'
      ]
      subject.extract.should == 'Hello world'
    end

    it 'joins with a blank for non block elements' do
      @file.should_receive(:readlines).and_return [
        '<p>Hello <strong>world</strong></p>',
        '<div>I hope the world is fine</div>'
      ]
      subject.extract.should == "Hello world\nI hope the world is fine"
    end

    it 'ignores elements that are not html' do
      @file.should_receive(:readlines).and_return [
        '<p>Hello </p>',
        "\n",
        '<div>world</div>'
      ]
      subject.extract.should == "Hello \nworld"
    end
  end
end
