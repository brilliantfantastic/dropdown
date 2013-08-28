require_relative '../inflector'

module Dropdown
  module Readers
    class ReaderFactory
      def self.create(reader, *args)
        constant_name = Inflector.new("#{reader}_reader").constant_name
        Dropdown::Readers.const_get(constant_name).new *args
      end
    end
  end
end
