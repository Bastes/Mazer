require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
 
$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')
require 'maze'
 
desc 'Default: run unit tests.'
task :default => [:clean, :test]
 
desc 'Test the maze gem.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end
 
desc 'Start an IRB session with all necessary files required.'
task :shell do |t|
  chdir File.dirname(__FILE__)
  exec 'irb -I lib/ -I lib/maze -r maze'
end
 
desc 'Generate documentation for the paperclip plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title = 'Maze'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
 
desc 'Clean up files.'
task :clean do |t|
  FileUtils.rm_rf "doc"
  Dir.glob("maze-*.gem").each { |f| FileUtils.rm f }
end
 
include_file_globs = ["README*",
                      "LICENSE",
                      "Rakefile",
                      "{lib,test}/**/*"]
exclude_file_globs = []
spec = Gem::Specification.new do |s|
  s.name = "Maze"
  s.version = Maze::VERSION
  s.author = "Michel Belleville"
  s.email = "michel.belleville@gmail.com"
  s.homepage = "http://github.com/Bastes/Maze/"
  s.platform = Gem::Platform::RUBY
  s.summary = "A simple tool to build and visit mazes."
  s.files = FileList[include_file_globs].to_a - FileList[exclude_file_globs].to_a
  s.require_path = "lib"
  s.autorequire = "maze"
  s.test_files = FileList["{test}/**/*test.rb"].to_a
  s.has_rdoc = true
  s.extra_rdoc_files = ["README"]
  s.rdoc_options << '--line-numbers' << '--inline-source'
  s.add_dependency("thoughtbot-shoulda", ">= 0")
end
 
desc "Print a list of the files to be put into the gem"
task :manifest => :clean do
  spec.files.each do |file|
    puts file
  end
end
 
desc "Generate a gemspec file"
task :gemspec => :clean do
  File.open("#{spec.name}.gemspec", 'w') do |f|
    f.write spec.to_ruby
  end
end
 
desc "Build the gem into the current directory"
task :gem => :gemspec do
  `gem build #{spec.name}.gemspec`
end

