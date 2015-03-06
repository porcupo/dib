require './lib/dib/version'

Gem::Specification.new do |s|
  s.name = "dib"
  s.version = Dib::VERSION     

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib", "bin"]
  s.authors = ["Doug Johnson"]
  s.date = Time.now.utc.strftime("%Y-%m-%d")
  s.description = "Gem that provides build/release functions for DI"
  s.email = "doug@porcupo.net"
  s.executables = ["dib"]
  s.extra_rdoc_files = [
                        "LICENSE.txt",
                        "README.md"
                       ]
  s.files = `git ls-files`.split("\n")
  s.homepage = "http://github.com/porcupo/dib"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.1"
  s.summary = "DI build/release tool"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib", "ext"]
  s.test_files = `git ls-files spec examples`.split("\n")
  s.add_runtime_dependency 'thor', '~> 0.18', '>= 0.18.1'
  s.add_runtime_dependency 'github_api', '~> 0.11', '>= 0.11.3'
  s.add_runtime_dependency 'slack-notifier', '~> 0.5', '>= 0.5.0'
  s.add_development_dependency 'tailor', '~> 1.4', '>= 1.4.0'
  s.add_development_dependency 'rspec', '~> 3.0', '>= 3.0.0'
  s.add_development_dependency 'bundler', '~> 1.0'
end
