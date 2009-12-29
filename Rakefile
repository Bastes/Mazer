require 'rake'
 
begin
  require 'jeweler'
  include_file_globs = ["README*",
                        "LICENSE",
                        "Rakefile",
                        "{lib,test}/**/*"]
  exclude_file_globs = []
  Jeweler::Tasks.new do |gem|
    gem.name = "mazer"
    gem.authors = ["Michel Belleville"]
    gem.email = "michel.belleville@gmail.com"
    gem.homepage = "http://github.com/Bastes/Mazer/"
    gem.platform = Gem::Platform::RUBY
    gem.summary = "A simple tool to build and visit mazes."
    gem.description = <<-EOF
      This gem provides simple tools to generate 2 dimensionnal mazes and
      traverse them.
    EOF
    gem.files = FileList[include_file_globs].to_a - FileList[exclude_file_globs].to_a
    gem.require_path = "lib"
    gem.test_files = FileList["{test}/**/test_*.rb"].to_a
    gem.has_rdoc = true
    gem.extra_rdoc_files = ["README"]
    gem.rdoc_options << '--line-numbers' << '--inline-source'
    gem.add_dependency("cellular_map", ">= 0.0.2")
    gem.add_development_dependency("thoughtbot-shoulda", ">= 0")
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
 
require 'rake/testtask'
desc 'Test the maze gem.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/test_*.rb'
  t.verbose = true
end

begin
  require 'rcov/rcovtask'
  desc 'Test coverage reports.'
  Rcov::RcovTask.new do |t|
    t.libs << 'test'
    t.pattern = 'test/**/test_*.rb'
    t.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
desc 'Generate documentation for the mazer gem.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ''

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "Mazer v#{version}"
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('LICENSE*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
 
desc 'Start an IRB session with all necessary files required.'
task :shell do |t|
  chdir File.dirname(__FILE__)
  exec 'irb -I lib/ -I lib/mazer -r mazer'
end
