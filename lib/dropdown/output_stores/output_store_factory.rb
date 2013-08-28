require_relative '../inflector'

module Dropdown
  module OutputStores
    class OutputStoreFactory
      def self.create(store, *args)
        constant_name = Inflector.new("#{store}_store").constant_name
        Dropdown::OutputStores.const_get(constant_name).new *args
      end
    end
  end
end
