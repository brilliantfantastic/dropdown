require 'nokogiri'
require_relative '../errors'
require_relative '../constants'

module Dropdown
  module Parsers

    class MetadataParser

      attr_accessor :file, :headers

      def initialize(file)
        raise ArgumentError if file.nil?
        raise Dropdown::FileTypeError if !Dropdown::HTML_EXTENSIONS.include? File.extname(file)
        @file = file
        @headers = {}
      end

      def parse
        doc = Nokogiri::HTML.parse(@file.readlines.join)
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
