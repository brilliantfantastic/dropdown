require_relative 'iterators/file_iterator'

module Dropdown
  class Processor
    attr_accessor :output_store,
                  :renderer

    def initialize
    end

    def markdown_iterator=(value)
      @iterator = value
    end

    def markdown_iterator
      if @iterator.nil?
        @iterator = Iterators::FileIterator.new
      end
      @iterator
    end

    def process
      markdown_iterator.each do |file|
        output_store.save renderer.render file
      end
    end
  end
end
