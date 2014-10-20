module Dropdown
  class Post
    attr_reader :source, :reader

    def title
      metadata[:title]
    end

    def author
      metadata[:author]
    end

    def date
      Date.parse metadata[:date]
    end

    # TODO: def slug
    # TODO: def to_param
    # TODO: def find_by_slug

    def body
      content
    end

    def excerpt
      unless @excerpt
        extractor = Dropdown::Parsers::ExcerptExtractor.new(content)
        @excerpt = extractor.extract
      end
      @excerpt
    end

    def initialize(source, reader)
      @source = source
      @reader = reader
    end

    private

    def metadata
      unless @metadata
        @metadata = Dropdown::Parsers::MetadataParser.new(content)
        @metadata.parse
      end
      @metadata.headers
    end

    def content
      @content ||= reader.read(@source)
    end
  end
end
