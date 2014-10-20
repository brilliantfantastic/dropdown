require_relative '../../spec_helper'
require_relative '../../../lib/dropdown/parsers/parser'
require_relative '../../../lib/dropdown/parsers/excerpt_extractor'

describe Dropdown::Parsers::ExcerptExtractor do
  describe '#extract' do
    # TODO: This needs a better test
    it 'extracts the first 120 characters' do
      subject = Dropdown::Parsers::ExcerptExtractor.new('Hello world')
      subject.extract.should == 'Hello world'
    end

    it 'extracts only the html content' do
      subject = Dropdown::Parsers::ExcerptExtractor.new('<p>Hello world</p>')
      subject.extract.should == 'Hello world'
    end

    it 'extracts multiple lines' do
      content = [
        '<p>Hello world</p>',
        '<div>I hope the world is fine</div>'
      ].join
      subject = Dropdown::Parsers::ExcerptExtractor.new content
      subject.extract.should == "Hello world\nI hope the world is fine"
    end

    it 'ignores comments' do
      content = [
        '<!-- This should be ignored -->',
        '<p>Hello world</p>'
      ].join
      subject = Dropdown::Parsers::ExcerptExtractor.new content
      subject.extract.should == 'Hello world'
    end

    it 'joins with a blank for non block elements' do
      content = [
        '<p>Hello <strong>world</strong></p>',
        '<div>I hope the world is fine</div>'
      ].join
      subject = Dropdown::Parsers::ExcerptExtractor.new content
      subject.extract.should == "Hello world\nI hope the world is fine"
    end

    it 'ignores elements that are not html' do
      content = [
        '<p>Hello </p>',
        "\n",
        '<div>world</div>'
      ].join
      subject = Dropdown::Parsers::ExcerptExtractor.new content
      subject.extract.should == "Hello \nworld"
    end
  end
end
