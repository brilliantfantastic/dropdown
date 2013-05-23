require 'tempfile'
require 'pathname'
require_relative '../../spec_helper'
require_relative '../../../lib/dropdown/iterators/file_iterator'

describe Dropdown::Iterators::FileIterator do
  describe '.initialize' do
    it 'should require a source path' do
      expect{ Dropdown::Iterators::FileIterator.new(nil) }.to raise_error ArgumentError
    end
  end

  describe '.each' do
    it 'should iterate over markdown files that end in .md' do
      file = Tempfile.new ['test', '.md']
      dir = Pathname.new(file.path).dirname
      expect{ |f| Dropdown::Iterators::FileIterator.new(dir).each(&f) }.to yield_with_args file.path
      file.delete
    end

    it 'should iterate over markdown files that end in .markdown' do
      file = Tempfile.new ['test', '.markdown']
      dir = Pathname.new(file.path).dirname
      expect{ |f| Dropdown::Iterators::FileIterator.new(dir).each(&f) }.to yield_with_args file.path
      file.delete
    end

    it 'should ignore files that are not markdown files' do
      file = Tempfile.new 'test'
      dir = Pathname.new(file.path).dirname
      expect{ |f| Dropdown::Iterators::FileIterator.new(dir).each(&f) }.not_to yield_control
      file.delete
    end

    it 'should handle an extra slash in the source' do
      file = Tempfile.new ['test', '.markdown']
      dir = "#{Pathname.new(file.path).dirname}/"
      expect{ |f| Dropdown::Iterators::FileIterator.new(dir).each(&f) }.to yield_with_args file.path
      file.delete
    end
  end
end

