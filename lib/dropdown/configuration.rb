module Dropdown
  class Configuration
    attr_accessor :renderer,
                  :dropbox_app_key,
                  :dropbox_app_secret,
                  :dropbox_access_token

    def initialize
      @renderer = :markdown_renderer
    end
  end
end
