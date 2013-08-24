module Dropdown
  class Configuration
    attr_accessor :renderer,
                  :dropdown_app_key,
                  :dropdown_app_secret,
                  :dropdown_access_token

    def initialize
      @renderer = :markdown_renderer
    end
  end
end
