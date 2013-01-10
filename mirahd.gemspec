# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "mirahd"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jan St\304\231pie\305\204"]
  s.date = "2013-01-10"
  s.description = "mirahd is a Mirah Daemon listening for your requests to compile something.\nWhen it receives one it does the job quickly. Really quickly.\n"
  s.email = "jstepien@users.sourceforge.net"
  s.executables = ["mirahd"]
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    ".rspec",
    ".travis.yml",
    "Gemfile",
    "Gemfile.lock",
    "README.md",
    "Rakefile",
    "VERSION",
    "bin/mirahd",
    "lib/mirahd/client.rb",
    "lib/mirahd/server.rb",
    "mirahd.gemspec",
    "test/client_spec.rb",
    "test/common.rb",
    "test/hello.mirah",
    "test/server_spec.rb"
  ]
  s.homepage = "https://github.com/jstepien/mirahd"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.15"
  s.summary = "Mirah compilation daemon (in dire need of Javanese name)"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mirah>, [">= 0"])
    else
      s.add_dependency(%q<mirah>, [">= 0"])
    end
  else
    s.add_dependency(%q<mirah>, [">= 0"])
  end
end

