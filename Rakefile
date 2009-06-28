require "active_support"
require 'rake/gempackagetask'

namespace :dev do
  desc "rebuild and reinstall gem"
  task :gem => ["gem:clobber_package", "gem:uninstall_local", "gem:install_local"]
  
end

namespace :gem do

  PACKAGE_NAME = "static-scaffolds"
  GEM_VERSION = "0.1"
  SUMMARY = "Generate attractive interfaces that are easy to edit."
  DESCRIPTION = SUMMARY


  spec = Gem::Specification.new do |s|
    s.name = PACKAGE_NAME
    s.version = GEM_VERSION
    s.date = Date.today
    s.summary = SUMMARY
    s.email = "jrhicks@gmail.com"
    s.homepage = "http://github.com/jrhicks/static-scaffolds"
    s.description = DESCRIPTION
    s.has_rdoc = true
    s.authors = ["Jeffrey Hicks"]
    s.files = Dir["README", "USAGE", "static_app/static_app_generator.rb", "static_app/templates/*",
                                     "static_gen_specs/static_gen_specs_generator.rb","static_gen_specs/templates/*",
                                     "static_scaffold/static_scaffold_generator.rb","static_scaffold/tempaltes/*"]
    s.test_files = Dir["/test/**/*"]
    s.rdoc_options = ["--main", "README"]    
    s.add_dependency("rails", [">= 2.3"])
  end    



  Rake::GemPackageTask.new(spec) do |p|
    p.gem_spec = spec
    p.need_tar = true
    p.need_zip = true
  end

  task :install_local => ["gem"] do
    sh "sudo gem install pkg/#{PACKAGE_NAME}-#{GEM_VERSION}.gem"
  end

  task :uninstall_local do
    sh "sudo gem uninstall #{PACKAGE_NAME} -x"        
  end

  
  desc "Create gem spec file"
  task :spec do
    f = File.open("#{PACKAGE_NAME}.gemspec", "w+")
    f << spec.to_ruby
    f.close
  end
  
end