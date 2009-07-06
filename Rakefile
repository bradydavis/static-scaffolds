require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('static-generators', '0.1.9') do |p|
  p.project        = "staticgenerators"
  p.description    = "Generate attractive interfaces that are easy to edit."
  p.url            = "http://github.com/jrhicks/static-scaffolds"
  p.author         = 'Jeffrey Hicks'
  p.email          = "jrhicks (at) gmail (dot) com"
  p.ignore_pattern = ["script/*", "rails_templates/*","Manifest",".gitignor"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
