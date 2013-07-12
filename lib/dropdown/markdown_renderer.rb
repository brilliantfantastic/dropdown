require 'redcarpet'

module Dropdown
  class MarkdownRenderer
    def initialize
      @markdown = Redcarpet::Markdown.new Redcarpet::Render::HTML
    end

    def render(file)
      @markdown.render File.read(file)
    end

    def output_filename(file)
      File.basename(file, '.md') + '.html'
    end
  end
end
