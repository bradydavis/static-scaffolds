gem 'jrhicks-static-scaffold'
 
rake("gems:install", :sudo => true)

# Install file column plugin and overwrite file_column.rb that has bug in Rails 2.3
run "sudo ruby script/plugin install http://opensvn.csie.org/rails_file_column/plugins/file_column/trunk"
run "curl http://gist.github.com/raw/136263/8a130be758d9a904ccfb8cf20e78643087bdf98e/file_column.rb > #{File.join(RAILS_ROOT,"vendor","plugins","file_column","lib","file_column.rb")}"

