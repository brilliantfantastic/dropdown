module Dropdown
  class Blog
    attr_accessor :name, :source
    attr_reader :posts

    def initialize(source=nil)
      @source = source
      @posts = []
      collect
    end

    private

    def collect
      unless @source.nil?
        Dir.glob("#{@source}/**/*.html") do |html_file|
          @posts << Post.new(html_file)
        end
      end
    end
  end
end
