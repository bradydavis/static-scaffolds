gem 'paperclip'
gem 'mislav-will_paginate', :version => '~> 2.2.3', :lib => 'will_paginate', :source => 'http://gems.github.com'
# gem 'justinfrench-formtastic', :lib => 'formtastic',  :source  => 'http://gems.github.com'
rake("gems:install", :sudo => true)
