require 'dropbox_sdk'

module Dropdown
  module Dropbox
    class Session
      attr_reader :authorize_url

      def initialize(app_key, app_secret)
        @flow = DropboxOAuth2FlowNoRedirect.new app_key, app_secret
        @authorize_url = @flow.start
      end

      def access_token(authorization_code)
        @flow.finish(authorization_code)[0]
      end
    end
  end
end
