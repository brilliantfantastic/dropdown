require_relative 'iterators/file_iterator'

module Dropdown
  class Processor
    attr_accessor :source,
                  :output_store,
                  :renderer

    def markdown_iterator=(value)
      @iterator = value
    end

    def markdown_iterator
      if @iterator.nil?
        @iterator = Iterators::FileIterator.new(source)
      end
      @iterator
    end

    def process
      markdown_iterator.each do |file|
        output_store.save renderer.render, renderer.output_filename
      end
    end
  end
end
