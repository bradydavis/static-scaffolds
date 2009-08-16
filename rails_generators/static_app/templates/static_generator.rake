namespace :static_force do
  desc "Generate a bunch of code and whipe-out anything you've done"
  
  task :all => [:gen_specs, :scaffold,:app] do
    
  end
  
  task :load_env do
    require File.dirname(__FILE__) + '/../../config/environment'
    require File.dirname(__FILE__) + '/../../config/boot'
    require 'rails_generator'
    require 'rails_generator/scripts/generate'
  end
  
  task :app => :load_env do
    Rails::Generator::Scripts::Generate.new.run(["static_app","-f","-t"])    
  end
  
  task :gen_specs => :load_env do
<%for table in ActiveRecord::Base.connection.tables - ["schema_migrations"]-%>
    Rails::Generator::Scripts::Generate.new.run(["static_gen_specs","<%=table.singularize%>","-f","-t"]) 
<%end -%>
  end
  
  task :scaffold => :load_env do
<%for table in ActiveRecord::Base.connection.tables - ["schema_migrations"]-%>
    Rails::Generator::Scripts::Generate.new.run(["static_scaffold","<%=table.singularize%>","-f","-t"]) 
<%end -%>    
  end
  
  task :populate_fake_all => :environment do 
<%for table in ActiveRecord::Base.connection.tables - ["schema_migrations"]-%>
    sh "rake db:populate_fake_<%=table%>"
<%end -%>    
  end
end
