module Dropdown
  module Parsers
    module Parser
      attr_accessor :content

      def initialize(content)
        raise ArgumentError if content.nil?
        @content = content
      end
    end
  end
end
