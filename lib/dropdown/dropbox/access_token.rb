require 'dropbox_sdk'

module Dropdown
  module Dropbox
    class AccessToken
      def self.authorize(app_key, app_secret)
        flow = DropboxOAuth2FlowNoRedirect.new app_key, app_secret
        flow.start
      end
    end
  end
end
