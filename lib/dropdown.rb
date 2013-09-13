require_relative 'dropdown/version'
require_relative 'dropdown/dropbox'
require_relative 'dropdown/processor'
require_relative 'dropdown/configuration'
require_relative 'dropdown/output_stores'
require_relative 'dropdown/readers'
require_relative 'dropdown/iterators'
require_relative 'dropdown/parsers/parser'
require_relative 'dropdown/parsers/metadata_parser'
require_relative 'dropdown/parsers/excerpt_extractor'
require_relative 'dropdown/markdown_renderer'
require_relative 'dropdown/blog'
require_relative 'dropdown/post'

module Dropdown
  def self.configuration
    @configuration ||= Dropdown::Configuration.new
  end

  def self.configure
    yield configuration if block_given?
  end
end
