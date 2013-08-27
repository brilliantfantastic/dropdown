module Dropdown
  module Readers
    class FileReader
      def read(path)
        File.read path
      end
    end
  end
end
