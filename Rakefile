require 'rubygems/package_task'
require "bundler/gem_tasks"

namespace :test do
  task :lib do
    Dir.glob("test/lib/*.rb").each do |file|
      puts "\nRunning : #{file}"
      system("ruby #{file}")
    end
  end
end

def gemspec
  $gem_gemspec ||= Gem::Specification.load("sm-infra.gemspec")
end

task :gem => :gemspec

desc %{Validate the gemspec file.}
task :gemspec do
  gemspec.validate
end

desc "Build but don't install gem"
task :build => :gemspec do
  sh "mkdir -p pkg"
  sh "gem build sm_web.gemspec"
  sh "mv doc_store-#{GemCheck::VERSION}.gem pkg"
end

desc "Release new version of gem to HP Gem Server"
task :release => :build do
  sh "gem inabox pkg/doc_store-#{GemCheck::VERSION}.gem --host #{ENV['HPGEMS_URL']}" # See below for a description of the HPGEMS_URL
end

desc "Install the gem"
task :install => :build do
  sh "gem install pkg/sm_infra-#{GemCheck::VERSION}.gem"
end
