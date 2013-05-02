module Dropdown
  class Processor
    attr_accessor :markdown_iterator,
                  :output_store,
                  :renderer

    def initialize
    end

    def process
      markdown_iterator.each do |file|
        output_store.save renderer.render file
      end
    end
  end
end
