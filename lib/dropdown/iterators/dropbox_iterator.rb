require 'dropbox_sdk'

module Dropdown
  module Iterators
    class DropboxIterator
      def initialize(source)
        raise ArgumentError if source.nil?
        @source = source.sub(/(\/)+$/, '')
      end

      def each
        contents = client.metadata(@source)['contents']
        contents.each do |child|
          unless child['is_dir']
            yield child['path']
          end
        end
      end

      private

      def client
        @client ||= DropboxClient.new(Dropdown.configuration.dropbox_access_token)
      end
    end
  end
end
