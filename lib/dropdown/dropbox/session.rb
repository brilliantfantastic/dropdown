require 'dropbox_sdk'

module Dropdown
  module Dropbox
    class Session
      attr_reader :authorize_url

      def initialize(app_key, app_secret)
        flow = DropboxOAuth2FlowNoRedirect.new app_key, app_secret
        @authorize_url = flow.start
      end
    end
  end
end
