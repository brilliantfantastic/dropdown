require 'dropbox_sdk'
require_relative '../constants'

module Dropdown
  module Readers
    class DropboxReader
      def read(path)
        client.get_file(path)
      end

      def find_html_files(path)
        files = []
        contents = client.metadata(path)['contents']
        contents.each do |child|
          unless child['is_dir']
            path = child['path']
            if Dropdown::HTML_EXTENSIONS.include? File.extname(path)
              files << path
            end
          end
        end
        files
      end

      private

      def client
        @client ||= DropboxClient.new(Dropdown.configuration.dropbox_access_token)
      end
    end
  end
end
