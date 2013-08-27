module Dropdown
  class Blog
    attr_accessor :name, :source
    attr_reader :reader, :posts

    def initialize(source=nil, reader=Dropdown::Readers::FileReader.new)
      @source = source
      @reader = reader
      @posts = []
      collect
    end

    private

    def collect
      unless @source.nil?
        @reader.find_html_files(@source).each do |html_file|
          @posts << Post.new(html_file)
        end
      end
    end
  end
end
