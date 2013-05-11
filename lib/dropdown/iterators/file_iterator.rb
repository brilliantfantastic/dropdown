module Dropdown
  module Iterators
    class FileIterator
      def initialize(source)
        raise ArgumentError if source.nil?
        @source = source.sub(/(\/)+$/, '')
      end

      def each
        Dir.glob("#{@source}/**/*.{md,markdown}") do |markdown_file|
          yield markdown_file
        end
      end
    end
  end
end
