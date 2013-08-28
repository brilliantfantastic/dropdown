require_relative '../inflector'

module Dropdown
  module Iterators
    class IteratorFactory
      def self.create(iterator, *args)
        constant_name = Inflector.new("#{iterator}_iterator").constant_name
        Dropdown::Iterators.const_get(constant_name).new *args
      end
    end
  end
end
