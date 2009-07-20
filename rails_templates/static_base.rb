gem 'jrhicks-static-generators', :source => 'http://gems.github.com'
gem 'paperclip'
gem 'mislav-will_paginate', :version => '~> 2.2.3', :lib => 'will_paginate', :source => 'http://gems.github.com'
generate(:static_app, "-f")
rake("gems:install", :sudo => true)



# Install file column plugin and overwrite file_column.rb that has bug in Rails 2.3
#run "sudo ruby script/plugin install http://opensvn.csie.org/rails_file_column/plugins/file_column/trunk"
#run "curl http://gist.github.com/raw/136263/8a130be758d9a904ccfb8cf20e78643087bdf98e/file_column.rb > #{File.join(RAILS_ROOT,"vendor","plugins","file_column","lib","file_column.rb")}"

# This is probably rude to do this here
# overwrite_irbrc = ask("Do you want to overwrite your personal .irbrc to customize your irb? (y/n)")
# if overwrite_irbrc=="y"
#  run "curl http://gist.github.com/raw/136255/c1ed51b0bae9710d03fa52d8a509e1f3a1c0f8a5/.irbrc > ~/.irbrc"
#end