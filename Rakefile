require 'bundler/gem_tasks'
require 'dotenv/tasks'

task :default => [:test]

desc 'Run tests for project'
task :test do
  sh 'bundle exec rspec'
end

desc 'Process the markdown files in a directory'
task :process, [:source_directory] => :dotenv do |t, args|
  require_relative 'lib/dropdown'
  Dropdown.configure do |c|
    c.dropbox_access_token = ENV['DROPBOX_ACCESS_TOKEN']
  end
  processor = Dropdown::Processor.new
  processor.source = args[:source_directory]
  processor.destination = File.join(processor.source, 'html')
  processor.storage = args[:storage] || :dropbox
  processor.renderer = :markdown_renderer
  processor.process
end

namespace :setup do
  namespace :dropbox do
    desc 'Store a new access token from Dropbox'
    task :access_token => :dotenv do |t, args|
      require 'launchy'
      require_relative 'lib/dropdown'

      key = args[:key] || ENV['DROPBOX_APP_KEY']
      secret = args[:secret] || ENV['DROPBOX_APP_SECRET']
      session = Dropdown::Dropbox::Session.new key, secret
      url = session.authorize_url
      puts "Opening the following url in your browser: #{url} ..."
      Launchy.open url
      puts "Paste the authorization code below and hit return: "
      code = STDIN.gets.strip
      token = session.access_token(code)
      puts "Your access token is: #{token}"
    end
  end
end
