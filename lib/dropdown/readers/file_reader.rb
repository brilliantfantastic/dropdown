module Dropdown
  module Readers
    class FileReader
      def read(path)
        File.read path
      end

      def find_html_files(path)
        Dir.glob("#{path}/**/*.html")
      end
    end
  end
end
