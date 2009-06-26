class StaticAppGenerator < Rails::Generator::Base
  def initialize(runtime_args, runtime_options = {})
    super
    @name = 'application'
  end
  
  def manifest
    record do |m|
      m.directory 'app/views/layouts'
      m.directory 'public/stylesheets'
      m.directory 'app/helpers'
      m.template "layout.html.erb", "app/views/layouts/application.html.erb"
      m.file "static_style.css", "public/stylesheets/static_style.css"
      m.file "sorttable.js", "public/javascripts/sorttable.js"
      m.file "application_helper.rb", "app/helpers/application_helper.rb"      
      m.file "layout_helper.rb", "app/helpers/layout_helper.rb"
    end
  end
   
  protected
  
    def banner
      "Creates layout, stylesheet, and helper files designed to be compatible with other static_scaffolds"
    end

end