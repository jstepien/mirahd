# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "mirahd"
  gem.homepage = "https://github.com/jstepien/mirahd"
  gem.license = "MIT"
  gem.summary = %Q{Mirah compilation daemon (in dire need of Javanese name)}
  gem.description = <<EOF
mirahd is a Mirah Daemon listening for your requests to compile something.
When it receives one it does the job quickly. Really quickly.
EOF
  gem.email = "jstepien@users.sourceforge.net"
  gem.authors = ["Jan Stępień"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['test/**/*_spec.rb']
end

task :default => :spec
