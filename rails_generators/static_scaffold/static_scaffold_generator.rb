class StaticScaffoldGenerator < Rails::Generator::NamedBase
  default_options :skip_timestamps => false, :skip_migration => false, :force_plural => false
  
  attr_reader   :controller_name,
                :controller_class_path,
                :controller_file_path,
                :controller_class_nesting,
                :controller_class_nesting_depth,
                :controller_class_name,
                :controller_underscore_name,
                :controller_singular_name,
                :controller_plural_name
  alias_method  :controller_file_name,  :controller_underscore_name
  alias_method  :controller_table_name, :controller_plural_name
  attr_accessor :count

  # The Scaffold Generator is configured with a ruby class
  spec_files = Dir.glob(File.join(RAILS_ROOT,"static_scaffold","*.rb"))
  for f in spec_files
      load f
  end

  def initialize(runtime_args, runtime_options = {})
    super

    if @name == @name.pluralize && !options[:force_plural]
      logger.warning "Plural version of the model detected, using singularized version.  Override with --force-plural."
      @name = @name.singularize
    end
    @count=0
    @controller_name = @name.pluralize

    base_name, @controller_class_path, @controller_file_path, @controller_class_nesting, @controller_class_nesting_depth = extract_modules(@controller_name)
    @controller_class_name_without_nesting, @controller_underscore_name, @controller_plural_name = inflect_names(base_name)
    @controller_singular_name=base_name.singularize
    if @controller_class_nesting.empty?
      @controller_class_name = @controller_class_name_without_nesting
    else
      @controller_class_name = "#{@controller_class_nesting}::#{@controller_class_name_without_nesting}"
    end
  end

  def next_count
      @count=@count+1
      return @count
  end

  def manifest
    record do |m|
      # Check for class naming collisions.
      m.class_collisions("#{controller_class_name}Controller", "#{controller_class_name}Helper")
      m.class_collisions(class_name)

      # Controller, helper, views, test and stylesheets directories.
      m.directory(File.join('app/models', class_path))
      m.directory(File.join('app/controllers', controller_class_path))
      m.directory(File.join('app/helpers', controller_class_path))
      m.directory(File.join('app/views', controller_class_path, controller_file_name))
      m.directory(File.join('app/views/layouts', controller_class_path))
      m.directory(File.join('test/functional', controller_class_path))
      m.directory(File.join('test/unit', class_path))
      m.directory(File.join('test/unit/helpers', class_path))
      m.directory(File.join('public/stylesheets', class_path))
      
      # Paperclip tokens initializer
      # http://blog.eizesus.com/2009/4/paperclip-custom-storage-path
      m.template("paperclip_tokens.rb",
            File.join("config","initializers","paperclip_tokens.rb"))

      # Fake Data Populator
      m.directory "lib/tasks"
      m.template("fake_data.rake",
                  File.join("lib/tasks","#{controller_singular_name.downcase}_fake_data.rake"))
                  

      # Model
      m.template(
            "model.rb",
            File.join('app/models',"#{@controller_singular_name.downcase}.rb"))

      # Faceted Search
      m.template("model_search.rb",
                  File.join('app/models',"#{@controller_singular_name.downcase}_search.rb"))
      m.template("partial_facet_form.html.erb",
                  File.join('app/views',controller_class_path, controller_file_name, "_facet_form.html.erb"))
                  
      # Views
      for action in scaffold_views
        m.template(
          "view_#{action}.html.erb",
          File.join('app/views', controller_class_path, controller_file_name, "#{action}.html.erb")
        )
      end

      # Partials
      for action in "entry_header index_header".split
        m.template(
          "#{action}.html.erb",
          File.join('app/views', controller_class_path, controller_file_name, "_#{action}.html.erb")
        )
      end
      

      # Layout and stylesheet.
      m.template('layout.html.erb', File.join('app/views/layouts', controller_class_path, "#{controller_file_name}.html.erb"))

      m.template(
        'controller.rb', File.join('app/controllers', controller_class_path, "#{controller_file_name}_controller.rb")
      )
      

      m.template('functional_test.rb', File.join('test/functional', controller_class_path, "#{controller_file_name}_controller_test.rb"))
      m.template('helper.rb',          File.join('app/helpers',     controller_class_path, "#{controller_file_name}_helper.rb"))
      m.template('helper_test.rb',     File.join('test/unit/helpers',    controller_class_path, "#{controller_file_name}_helper_test.rb"))

      m.route_resources controller_file_name

      #m.dependency 'model', [name] + @args, :collision => :skip
    end
  end

  protected
    # Override with your own usage banner.
    def banner
      "Usage: #{$0} static_scaffold ModelName"
    end

    def add_options!(opt)
      opt.separator ''
      opt.separator 'Options:'
      opt.on("--skip-timestamps",
             "Don't add timestamps to the migration file for this model") { |v| options[:skip_timestamps] = v }
      opt.on("--skip-migration",
             "Don't generate a migration file for this model") { |v| options[:skip_migration] = v }
      opt.on("--force-plural",
             "Forces the generation of a plural ModelName") { |v| options[:force_plural] = v }
    end

    def scaffold_views
      %w[ index show new edit ]
    end

    def model_name
      class_name.demodulize
    end
    
    # generator specs
    def gen_spec(mname=nil)
        mname = model_name if not mname
        gen_specs_mname = "#{mname}GenSpecs"
        Object::const_get(gen_specs_mname).new()
    end
    
    class CodeJustifier   
        # This class is designed to generate readable code, but is a hypocrate

        attr_accessor :objects, :parameters

        def initialize(objects)
            self.objects = objects
            self.parameters = []
        end

        def add_parameter(&p)
            self.parameters << p
        end

        def render(object,delimiter)
            self.parameters.map {|p| p.call(o).ljust(max_length(p))+1}.join(delimeter)
        end

        def max_length(parameter)
            self.objects.map {|o| parameter.call(o).to_s.length }.max
        end
    end
end


