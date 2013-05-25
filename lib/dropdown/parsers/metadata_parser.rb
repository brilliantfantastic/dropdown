module Dropdown
  module Parsers

    class MetadataParser

      EXTENSIONS = %w(.md .markdown)

      attr_accessor :file, :headers

      def initialize(file)
        raise ArgumentError if file.nil?
        raise ArgumentError if !EXTENSIONS.include? File.extname(file)
        @file = file
        @headers = {}
      end

      def parse_headers
        post = @file.readlines
        empty_line_index = post.find_index { |line| /^\s$/.match(line) }
        header_lines = post[0...empty_line_index]
        header_lines.each { |line| extract_header(line) }
      end

      private

      def extract_header(line)
        pair = line.split(/:(.+)?/).map(&:strip)
        @headers[pair[0].downcase.to_sym] = pair[1]
      end
    end

  end
end
