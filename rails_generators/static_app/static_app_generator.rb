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
      
      # jrails plugin
      m.directory 'vendor/plugins/jrails'
      m.directory 'vendor/plugins/jrails/lib'
      m.directory 'vendor/plugins/jrails/tasks'
      m.directory 'vendor/plugins/jrails/javascripts'
      m.directory 'vendor/plugins/jrails/javascripts/sources'
      
      # jrails plugin files
      [
        "CHANGELOG",
        "init.rb",
        "install.rb",
        "README",
        "javascripts/jquery-ui.js",
        "javascripts/jquery.js",
        "javascripts/jrails.js",
        "javascripts/sources/jrails.js",
        "lib/jrails.rb",
        "tasks/jrails.rake"
      ].each {|f| m.file "plugins/jrails/#{f}", "vendor/plugins/jrails/#{f}"}

      # jrails javascript Files
      [
        "javascripts/jquery-ui.js",
        "javascripts/jquery.js",
        "javascripts/jrails.js",
      ].each {|f| m.file "plugins/jrails/#{f}", "public/#{f}"}
        
      # jquery theme and additional modules
      m.directory "public/stylesheets/redmond/images"
      [
        "redmond/images/ui-bg_flat_0_aaaaaa_40x100.png",
        "redmond/images/ui-bg_flat_55_fbec88_40x100.png",
        "redmond/images/ui-bg_glass_75_d0e5f5_1x400.png",
        "redmond/images/ui-bg_glass_85_dfeffc_1x400.png",
        "redmond/images/ui-bg_glass_95_fef1ec_1x400.png",
        "redmond/images/ui-bg_gloss-wave_55_5c9ccc_500x100.png",
        "redmond/images/ui-bg_inset-hard_100_f5f8f9_1x100.png",
        "redmond/images/ui-bg_inset-hard_100_fcfdfd_1x100.png",
        "redmond/images/ui-icons_217bc0_256x240.png",
        "redmond/images/ui-icons_2e83ff_256x240.png",
        "redmond/images/ui-icons_469bdd_256x240.png",
        "redmond/images/ui-icons_6da8d5_256x240.png",
        "redmond/images/ui-icons_cd0a0a_256x240.png",
        "redmond/images/ui-icons_d8e7f3_256x240.png",
        "redmond/images/ui-icons_f9bd01_256x240.png",
        "redmond/jquery-ui-1.7.2.custom.css"
      ].each {|f| m.file "jquery-ui-1.7.2.custom/css/#{f}", "public/stylesheets/#{f}"}
        
      m.file "jquery-ui-1.7.2.custom/js/jquery-1.3.2.min.js", "public/javascripts/jquery-1.3.2.min.js"
      m.file "jquery-ui-1.7.2.custom/js/jquery-ui-1.7.2.custom.min.js", "public/javascripts/jquery-ui-1.7.2.custom.min.js"

      # header and footer
      m.directory 'app/views/shared'
      m.template "standard_navigation.html.erb", "app/views/shared/_standard_navigation.html.erb"
      m.template "standard_header.html.erb", "app/views/shared/_standard_header.html.erb"
      m.template "standard_footer.html.erb", "app/views/shared/_standard_footer.html.erb"
      m.template "standard_banner.html.erb", "app/views/shared/_standard_banner.html.erb"
      m.file "header_bg.png", "public/images/header_bg.png"
      #m.template "standard_banner_user.html.erb", "app/views/shared/_standard_banner_user.html.erb"

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