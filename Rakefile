require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('static-scaffolds', '0.5.45') do |p|
  p.project        = "static_scaffolds"
  p.description    = "Generate attractive interfaces that are easy to edit."
  p.url            = "http://github.com/jrhicks/static-scaffolds"
  p.author         = 'Jeffrey Hicks'
  p.email          = "jrhicks (at) gmail (dot) com"
  p.ignore_pattern = ["script/*", "rails_templates/*","Manifest",".gitignor"]
  p.development_dependencies = []
  p.runtime_dependencies = ["mislav-will_paginate","faker","populator"]  
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
