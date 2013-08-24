require_relative '../constants'

module Dropdown
  module Iterators
    class FileIterator
      def initialize(source)
        raise ArgumentError if source.nil?
        @source = source.sub(/(\/)+$/, '')
      end

      def each
        Dir.glob("#{@source}/**/*{#{Dropdown::MARKDOWN_EXTENSIONS.join(',')}}") do |markdown_file|
          yield markdown_file
        end
      end
    end
  end
end
