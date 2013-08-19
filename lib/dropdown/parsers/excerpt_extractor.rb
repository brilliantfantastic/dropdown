require 'nokogiri'

module Dropdown
  module Parsers
    class ExcerptExtractor
      include Parser

      def extract
        @results = ''
        doc = Nokogiri::HTML.parse(@file.readlines.join)
        process_element doc
        @results.chomp
      end

      private

      def process_element(element)
        if element.text?
          @results << element.text.chomp
        else
          unless element.description.nil?
            # save the seperator for later
            seperator = element.description.block? ? "\n" : " "
          end
        end

        element.children.map { |el| process_element(el) }

        # Display a seperator if we are done processing the children
        if !element.children.empty? &&
           !seperator.nil? &&
           !['html', 'body'].include?(element.name)
          @results << seperator unless seperator.nil?
        end
      end
    end
  end
end
