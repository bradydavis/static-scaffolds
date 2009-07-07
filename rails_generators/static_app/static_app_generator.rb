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
      
      #Uni-formn
      m.file "uni-form-generic.css", "public/stylesheets/uni-form-generic.css"
      m.file "uni-form.css","public/stylesheets/uni-form.css"
      m.file "uni-form.jquery.js", "public/javascripts/uni-form.jquery.js"
      m.file "jquery.js", "public/javascripts/jquery.js"      
    end
  end
   
  protected
  
    def banner
      "Creates layout, stylesheet, and helper files designed to be compatible with other static_scaffolds"
    end

end