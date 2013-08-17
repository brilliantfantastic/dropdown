module Dropdown
  module Parsers
    class ExcerptExtractor
      include Parser

      def extract
        @file.readlines.join
      end
    end
  end
end
