task :default => [:test]

desc 'Run tests for project'
task :test do
  sh 'bundle exec rspec'
end

desc 'Process the markdown files in a directory'
task :process, :source_directory do |t, args|
  require_relative 'lib/dropdown'
  processor = Dropdown::Processor.new
  processor.source = args[:source_directory]
  destination = File.join(processor.source, 'html')
  processor.output_store = Dropdown::OutputStore.new destination
  processor.renderer = :markdown_renderer
  processor.process
end
