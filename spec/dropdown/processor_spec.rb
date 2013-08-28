require_relative '../spec_helper'
require_relative '../../lib/dropdown'

describe Dropdown::Processor do
  describe '#process' do
    let(:iterator) { double }
    subject { Dropdown::Processor.new }

    it 'loops through each file in a source directory' do
      subject.markdown_iterator = iterator

      iterator.should_receive(:each).once

      subject.process
    end

    describe '#storage' do
      before do
        subject.source = 'blah'
        subject.storage = :dropbox
      end

      it 'creates the appropriate instance of the reader' do
        subject.reader.should be_a Dropdown::Readers::DropboxReader
      end

      it 'creates the appropriate instance of the iterator' do
        subject.markdown_iterator.should be_a Dropdown::Iterators::DropboxIterator
      end

      it 'creates the appropriate instance of the output store' do
        subject.output_store.should be_a Dropdown::OutputStores::DropboxStore
      end
    end

    context 'with some files' do
      class FakeRenderer
        attr_accessor :reader
        def initialize(file_path); end
      end

      let(:files) { [double, double] }
      let(:store) { double }

      before do
        iterator.should_receive(:each).and_yield(files[0]).and_yield(files[1])
        subject.markdown_iterator = iterator
        subject.renderer = :fake_renderer
        FakeRenderer.any_instance.stub(:output_filename)
      end

      it 'loops through each file and renders HTML' do
        store.as_null_object
        subject.output_store = store

        render_count = 0
        FakeRenderer.any_instance.stub(:render) { render_count += 1 }
        subject.process
        render_count.should == 2
      end

      it 'stores the rendered file' do
        FakeRenderer.any_instance.stub(:render)
        subject.output_store = store

        store.should_receive(:save).exactly(files.count).times
        subject.process
      end
    end
  end

  describe 'defaults' do
    let(:configuration) { Dropdown::Configuration.new }
    subject { Dropdown::Processor.new }

    it 'should initialize with the configuration defaults' do
      subject.renderer.should == configuration.renderer
    end
  end
end
