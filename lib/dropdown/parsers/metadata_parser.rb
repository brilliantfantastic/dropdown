require 'nokogiri'

module Dropdown
  module Parsers

    class MetadataParser
      include Parser

      attr_accessor :headers

      def initialize(content)
        super
        @headers = {}
      end

      def parse
        doc = Nokogiri::HTML.parse(@content)
        doc.xpath('//comment()').each { |comment| extract_header(comment.content) }
      end

      private

      def extract_header(line)
        pair = line.split(/:(.+)?/).map(&:strip)
        @headers[pair[0].downcase.to_sym] = pair[1]
      end
    end

  end
end
