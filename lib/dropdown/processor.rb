require_relative 'renderer_factory'

module Dropdown
  class Processor
    attr_accessor :source,
                  :destination,
                  :storage,
                  :reader,
                  :markdown_iterator,
                  :output_store,
                  :renderer

    def initialize
      @renderer = Dropdown.configuration.renderer
    end

    def storage=(value)
      @storage = value
      self.reader = Dropdown::Readers::ReaderFactory.create(value)
      self.markdown_iterator = Dropdown::Iterators::IteratorFactory.create(value, self.source)
      self.output_store = Dropdown::OutputStores::OutputStoreFactory.create(value, self.destination)
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
