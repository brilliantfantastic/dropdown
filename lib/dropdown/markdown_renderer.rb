require 'redcarpet'

module Dropdown
  class MarkdownRenderer
    attr_reader :file

    def initialize(file)
      @file = file
      @markdown = Redcarpet::Markdown.new Redcarpet::Render::HTML
    end

    def render
      @markdown.render File.read(file)
    end

    def output_filename
      File.basename(file, '.md') + '.html'
    end
  end
end
