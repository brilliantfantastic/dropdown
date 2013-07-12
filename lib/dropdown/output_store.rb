module Dropdown
  class OutputStore
    attr_reader :path

    def initialize(output_path)
      @output_path = output_path
    end

    def save(html)
      create_directory @output_path
      @path = "#{@output_path}/test.html"
      File.open(@path, 'w+') { |f| f.write html }
    end

    private

    def create_directory(path)
      FileUtils.mkdir_p(path)
    end
  end
end
