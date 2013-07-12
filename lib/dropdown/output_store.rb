module Dropdown
  class OutputStore
    attr_reader :path

    def initialize(initial_path)
      @initial_path = initial_path
    end

    def save(html)
      #TODO: Filename should be MD5 hash?
      @path = "#{@initial_path}/test.html"
      File.open(@path, 'w+') { |f| f.write html }
    end
  end
end
