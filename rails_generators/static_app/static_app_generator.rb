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
      m.file "application_helper.rb", "app/helpers/application_helper.rb"      
      m.file "layout_helper.rb", "app/helpers/layout_helper.rb"

      # BluePrint CSS
      m.file "blueprint/grid.png", "public/images/blueprint_css_grid.png"
      m.file "blueprint/print.css", "public/stylesheets/print.css"
      m.file "blueprint/ie.css", "public/stylesheets/ie.css"
      m.file "blueprint/screen.css", "public/stylesheets/screen.css"

      # header and footer
      m.directory 'app/views/shared'
      m.template "standard_navigation.html.erb", "app/views/shared/_standard_navigation.html.erb"
      m.template "standard_header.html.erb", "app/views/shared/_standard_header.html.erb"
      m.template "standard_footer.html.erb", "app/views/shared/_standard_footer.html.erb"

      # Sorttable Tables
      m.file "sorttable/sorttable.js", "public/javascripts/sorttable.js"  
                  
      # icons
      m.directory 'public/images/icons'
      pngs = "tick cross feed key doc external pdf email visited xls".split()
      for file in pngs
        m.file "icons/#{file}.png", "public/images/icons/#{file}.png"
      end
      
      #Uni-formn
      m.file "uni-form/uni-form-generic.css", "public/stylesheets/uni-form-generic.css"
      m.file "uni-form/uni-form.css","public/stylesheets/uni-form.css"
      m.file "uni-form/uni-form.jquery.js", "public/javascripts/uni-form.jquery.js"
      m.file "uni-form/jquery.js", "public/javascripts/jquery.js"      
    end
  end
   
  protected
  
    def banner
      "Creates layout, stylesheet, and helper files designed to be compatible with other static_scaffolds"
    end

end