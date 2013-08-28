require_relative '../../spec_helper'
require_relative '../../../lib/dropdown/parsers/parser'

class MyParser
  include Dropdown::Parsers::Parser
end

describe Dropdown::Parsers::Parser do
  context 'raising errors' do
    it 'requires some content' do
      expect {
          MyParser.new(nil)
        }.to raise_error ArgumentError
    end
  end

  context 'setting instance variables' do
    let(:content) { "Hello world" }

    subject { MyParser.new(content) }

    it 'sets the content' do
      subject.content.should == content
    end
  end
end
