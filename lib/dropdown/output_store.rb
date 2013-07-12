module Dropdown
  class OutputStore
    attr_reader :path

    def initialize(output_path)
      @output_path = output_path
    end

    def save(contents, file_name)
      create_directory @output_path
      @path = "#{@output_path}/#{file_name}"
      File.open(@path, 'w+') { |f| f.write contents }
    end

    private

    def create_directory(path)
      FileUtils.mkdir_p(path)
    end
  end
end
