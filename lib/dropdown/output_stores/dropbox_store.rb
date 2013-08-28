require 'dropbox_sdk'

module Dropdown
  module OutputStores
    class DropboxStore
      attr_reader :path

      def initialize(output_path)
        @output_path = output_path
      end

      def save(contents, file_name)
        @path = File.join @output_path, file_name
        client.put_file(@path, contents, true)
      end

      private

      def client
        @client ||= DropboxClient.new(Dropdown.configuration.dropbox_access_token)
      end
    end
  end
end
