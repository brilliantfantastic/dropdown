require 'redcarpet'

module Dropdown
  class MarkdownRenderer
    def initialize
      @markdown = Redcarpet::Markdown.new Redcarpet::Render::HTML
    end

    def render(file)
      @markdown.render File.read(file)
    end
  end
end
