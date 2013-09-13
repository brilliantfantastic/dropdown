# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dropdown/version'

Gem::Specification.new do |spec|
  spec.name          = "dropdown"
  spec.version       = Dropdown::VERSION

  spec.authors       = ["Jamie Wright", "Keith Thompson"]
  spec.email         = ["jamie@brilliantfantastic.com", "keith@brilliantfantastic.com"]

  spec.summary       = "Markdown blog engine in Dropbox"
  spec.description   = %q{
                        A simple blog engine that reads blog posts from a Dropbox source.
                        Rake tasks will convert any blog post from Markdown to HTML and 
                        store them back into Dropbox for the Blog objects to read.
                       }

  spec.homepage      = "http://github.com/brilliantfantastic/dropdown"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "bundler", "~> 1.3"
  spec.add_dependency "rake"
  spec.add_dependency "dotenv"
  spec.add_dependency "launchy"
  spec.add_dependency "redcarpet"
  spec.add_dependency "nokogiri"
  spec.add_dependency "dropbox-sdk"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "fakeweb"
end
