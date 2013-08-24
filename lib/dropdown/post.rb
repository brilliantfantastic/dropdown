module Dropdown
  class Post
    attr_reader :source

    def title
      metadata[:title]
    end

    def author
      metadata[:author]
    end

    def date
      Date.parse metadata[:date]
    end

    def body
      file.readlines.join
    end

    def excerpt
      unless @excerpt
        extractor = Dropdown::Parsers::ExcerptExtractor.new(file)
        @excerpt = extractor.extract
      end
      @excerpt
    end

    def initialize(source)
      @source = source
    end

    private

    def metadata
      unless @metadata
        @metadata = Dropdown::Parsers::MetadataParser.new(file)
        @metadata.parse
      end
      @metadata.headers
    end

    def file
      @file = File.new(@source, 'r') unless @file
      @file
    end
  end
end
