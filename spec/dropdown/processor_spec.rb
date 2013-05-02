require_relative '../../lib/dropdown'

describe Dropdown::Processor do
  describe '.process' do
    let(:iterator) { double }
    let(:renderer) { double }
    subject { Dropdown::Processor.new }

    it 'loops through each file in a source directory' do
      subject.markdown_iterator = iterator

      iterator.should_receive(:each).once

      subject.process
    end

    context 'with some files' do
      let(:files) { [double, double] }
      let(:store) { double }

      it 'loops through each file and renders HTML' do
        iterator.should_receive(:each).and_yield(files[0]).and_yield(files[1])
        subject.markdown_iterator = iterator
        store.as_null_object
        subject.output_store = store

        subject.renderer = renderer

        files.each { |file| renderer.should_receive(:render).with file }
        subject.process
      end

      it 'stores the rendered file' do
        iterator.should_receive(:each).and_yield(files[0]).and_yield(files[1])
        subject.markdown_iterator = iterator
        renderer.as_null_object
        subject.renderer = renderer

        subject.output_store = store

        store.should_receive(:save).exactly(files.count).times
        subject.process
      end
    end

    context 'updating an existing markdown file' do
    end
  end
end
