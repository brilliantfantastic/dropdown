require 'dropbox_sdk'

module Dropdown
  module Readers
    class DropboxReader
      def read(path)
        client.get_file(path)
      end

      private

      def client
        @client ||= DropboxClient.new(Dropdown.configuration.dropbox_access_token)
      end
    end
  end
end
