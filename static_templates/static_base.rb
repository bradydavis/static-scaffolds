gem 'jrhicks-static-scaffold'
 
rake("gems:install", :sudo => true)

run "sudo ruby script/plugin install http://opensvn.csie.org/rails_file_column/plugins/file_column/trunk"
run "patch line 619 "
