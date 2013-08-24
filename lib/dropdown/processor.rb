require_relative 'renderer_factory'
require_relative 'iterators/file_iterator'

module Dropdown
  class Processor
    attr_accessor :source,
                  :renderer,
                  :output_store

    class << self
      def configuration
        @configuration ||= Dropdown::Configuration.new
      end
    end

    def initialize
      @renderer = self.class.configuration.renderer
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
      RendererFactory.create(renderer, file)
    end
  end
end
