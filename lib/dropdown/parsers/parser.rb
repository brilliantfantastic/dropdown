require_relative '../errors'
require_relative '../constants'

module Dropdown
  module Parsers
    module Parser
      attr_accessor :file

      def initialize(file)
        raise ArgumentError if file.nil?
        raise Dropdown::FileTypeError if !Dropdown::HTML_EXTENSIONS.include? File.extname(file)
        @file = file
      end
    end
  end
end
