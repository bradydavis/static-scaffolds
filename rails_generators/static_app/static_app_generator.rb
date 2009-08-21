spec_files = Dir.glob(File.join(RAILS_ROOT,"static_scaffold","*.rb"))
for f in spec_files
    load f
end

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
      m.file "application_controller.rb", "app/controllers/application_controller.rb"        
      m.file "application_helper.rb", "app/helpers/application_helper.rb"      
      m.file "layout_helper.rb", "app/helpers/layout_helper.rb"
      
      # Rake Tasks
      m.directory "lib/tasks"
      m.template("static_generator.rake",
                  File.join("lib/tasks","static_generate.rake"))
                  
      # BluePrint CSS
      m.file "blueprint/print.css", "public/stylesheets/print.css"
      m.file "blueprint/ie.css", "public/stylesheets/ie.css"
      m.file "blueprint/screen.css", "public/stylesheets/screen.css"
      
      # jrails plugin
      m.directory 'vendor/plugins/jrails'
      m.directory 'vendor/plugins/jrails/lib'
      m.directory 'vendor/plugins/jrails/tasks'
      m.directory 'vendor/plugins/jrails/javascripts'
      m.directory 'vendor/plugins/jrails/javascripts/sources'

      # Faceted Search
      m.directory "lib/faceted_search"
      m.file("faceted_search/lib/base.rb","lib/faceted_search/base.rb")
      m.file("faceted_search/lib/facet.rb","lib/faceted_search/facet.rb")
      m.file("faceted_search/lib/keyword_facet.rb","lib/faceted_search/keyword_facet.rb")
      m.file("faceted_search/lib/numeric_range_facet.rb","lib/faceted_search/numeric_range_facet.rb")
      m.file("faceted_search/lib/date_range_facet.rb","lib/faceted_search/date_range_facet.rb")      
      m.file("faceted_search/lib/checkbox_facet.rb","lib/faceted_search/checkbox_facet.rb")      

      m.directory "app/views/faceted_search"
      m.file("faceted_search/views/active_facets.html.erb","app/views/faceted_search/_active_facets.html.erb")      
      m.file("faceted_search/views/keyword_facet.html.erb","app/views/faceted_search/_keyword_facet.html.erb")
      m.file("faceted_search/views/numeric_range_facet.html.erb","app/views/faceted_search/_numeric_range_facet.html.erb")
      m.file("faceted_search/views/date_range_facet.html.erb","app/views/faceted_search/_date_range_facet.html.erb")
      m.file("faceted_search/views/checkbox_facet.html.erb","app/views/faceted_search/_checkbox_facet.html.erb")
      
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
      m.template "standard_header.html.erb", "app/views/shared/_standard_header.html.erb"
      m.template "standard_footer.html.erb", "app/views/shared/_standard_footer.html.erb"
      m.template "standard_banner.html.erb", "app/views/shared/_standard_banner.html.erb"
      m.template "root_model_selector.html.erb", "app/views/shared/_root_model_selector.html.erb"
      m.template "standard_navigation.html.erb", "app/views/shared/_standard_navigation.html.erb"
      m.file "header_bg.png", "public/images/header_bg.png"
      #m.template "standard_banner_user.html.erb", "app/views/shared/_standard_banner_user.html.erb"

      # Misc Javascripts
      m.file "sorttable/sorttable.js", "public/javascripts/sorttable.js"  
      m.file "ajax.js", "public/javascripts/ajax.js"
                  
      # icons
      m.directory 'public/images/icons'
      pngs = "add map_go pencil tick cross feed key doc external pdf email visited xls".split()
      for file in pngs
        m.file "icons/#{file}.png", "public/images/icons/#{file}.png"
      end
      gifs = "toggle-down-arrow toggle-right-arrow blue_bg_ajax_loader loading close_window".split()
      for file in gifs
        m.file "icons/#{file}.gif", "public/images/icons/#{file}.gif"
      end
             
    end
  end
   
  protected
  
  
  def gen_spec_constantize(mname)
      if mname.class==Array
          return mname.map {|m|m.constantize_gen_spec}
      else
          # Instantiate the GenSpec based on model name
          mname = model_name if not mname
          gen_specs_mname = "#{mname}GenSpecs"
          Object::const_get(gen_specs_mname).new()
      end
  end
  
    def root_models
      # TODO: filter to only non-nested models
      tables=ActiveRecord::Base.connection.tables - ["schema_migrations"]
      results = []
      for t in tables
        begin
          gen_spec=gen_spec_constantize(t.singularize.camelcase)
          if not gen_spec.nested_by
            results.<< t
          end
        rescue
        end
      end
      results
    end
  
    def banner
      "Creates layout, stylesheet, and helper files designed to be compatible with other static_scaffolds"
    end

end