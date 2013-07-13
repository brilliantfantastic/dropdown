require_relative 'inflector'

module Dropdown
  class RendererFactory
    def self.create(renderer, *args)
      constant_name = Inflector.new(renderer).constant_name
      Dropdown.const_get(constant_name).new *args
    end
  end
end
