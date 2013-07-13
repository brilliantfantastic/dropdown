module Dropdown
  class Configuration
    attr_accessor :renderer

    def initialize
      @renderer = :markdown_renderer
    end
  end
end
