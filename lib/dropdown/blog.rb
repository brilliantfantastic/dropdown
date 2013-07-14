module Dropdown
  class Blog
    attr_accessor :source
    attr_reader :posts

    def initialize(source=nil)
      @source = source
      @posts = []
    end
  end
end
