require 'nokogiri'

module Dropdown
  module Parsers
    class ExcerptExtractor
      include Parser

      def extract
        doc = Nokogiri::HTML.parse(@file.readlines.join)
        doc.search('//text()').map(&:text).join("\n")
      end
    end
  end
end
