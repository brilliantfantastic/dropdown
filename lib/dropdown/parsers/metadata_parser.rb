require 'nokogiri'
require_relative '../errors'
require_relative '../constants'

module Dropdown
  module Parsers

    class MetadataParser

      attr_accessor :file, :headers

      def initialize(file)
        raise ArgumentError if file.nil?
        #raise Dropdown::FileTypeError if !Dropdown::EXTENSIONS.include? File.extname(file)
        @file = file
        @headers = {}
      end

      def parse
        post = @file.readlines
        empty_line_index = post.find_index { |line| /^\s$/.match(line) }
        header_lines = post[0...empty_line_index]
        header_lines.each { |line| extract_header(line) }
      end

      def parse_xml
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
