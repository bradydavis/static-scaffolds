namespace :static_force do
  desc "Generate a bunch of code and whipe-out anything you've done"
  
  task :all => [:gen_specs, :scaffold,:app] do
    
  end
  
  task :app  do
    sh "ruby <%=RAILS_ROOT%>/script/generate static_app -f -t"
  end
  
  task :gen_specs => :environment do
<%for table in ActiveRecord::Base.connection.tables -%>
    sh "ruby <%=RAILS_ROOT%>/script/generate static_gen_specs <%=table.singularize%> -f -t"
<%end -%>
  end
  
  task :scaffold => :environment do
<%for table in ActiveRecord::Base.connection.tables -%>
    sh "ruby <%=RAILS_ROOT%>/script/generate static_scaffold <%=table.singularize%> -f -t"
<%end -%>    
  end
  
  task :populate_fake_all => :environment do 
<%for table in ActiveRecord::Base.connection.tables -%>
    sh "rake db:populate_fake_<%=table%>"
<%end -%>    
  end
end
