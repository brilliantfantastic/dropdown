require_relative '../spec_helper'
require_relative '../../lib/dropdown'

describe Dropdown::Post do
  let(:current_directory) { File.expand_path File.dirname(__FILE__) }
  let(:processed_file) { File.join current_directory, '../fixtures/processed/my-trip-to-africa.html' }
  subject { Dropdown::Post.new(processed_file) }

  describe '#source' do
    it 'is initialized with a path to an html file' do
      source = 'foo'
      Dropdown::Post.new(source).source.should == source
    end
  end

  describe 'retrieving metadata' do
    it 'returns the title from the html contents' do
      subject.title.should == 'My trip to Africa'
    end

    it 'returns the author from the html contents' do
      subject.author.should == 'Jane Goodall'
    end

    it 'returns the date from the html contents' do
      subject.date.should == Date.parse('4/4/1989')
    end
  end

  describe '#body' do
    it 'returns the full html' do
      subject.body.should == File.new(processed_file, 'r').readlines.join
    end
  end
end
