require_relative 'renderer_factory'

module Dropdown
  class Processor
    attr_accessor :source,
                  :storage,
                  :reader,
                  :renderer,
                  :output_store

    def initialize
      @renderer = Dropdown.configuration.renderer
    end

    def storage=(value)
      @storage = value
      self.reader = Dropdown::Readers::ReaderFactory.create(value)
    end

    def markdown_iterator=(value)
      @iterator = value
    end

    def markdown_iterator
      @iterator ||= Iterators::FileIterator.new(source)
    end

    def process
      markdown_iterator.each do |file|
        renderer = renderer_for file
        output_store.save renderer.render, renderer.output_filename
      end
    end

    private

    def renderer_for(file)
      r = RendererFactory.create(renderer, file)
      r.reader = reader
      r
    end
  end
end
