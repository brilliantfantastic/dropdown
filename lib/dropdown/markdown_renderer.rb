require 'redcarpet'

module Dropdown
  class MarkdownRenderer
    attr_reader :file_path
    attr_accessor :reader

    def initialize(file_path)
      @file_path = file_path
      @markdown = Redcarpet::Markdown.new Redcarpet::Render::HTML
    end

    def render
      @markdown.render reader.read(file_path)
    end

    def output_filename
      File.basename(file_path, '.md') + '.html'
    end
  end
end
