class StaticGenSpecsGenerator < Rails::Generator::NamedBase
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


  def initialize(runtime_args, runtime_options = {})
    super

    if @name == @name.pluralize && !options[:force_plural]
      logger.warning "Plural version of the model detected, using singularized version.  Override with --force-plural."
      @name = @name.singularize
    end

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

  def manifest
    record do |m|
        # Check for class naming collisions.
        m.class_collisions("#{controller_class_name}Controller", "#{controller_class_name}Helper")
        m.class_collisions(class_name)

        # Controller, helper, views, test and stylesheets directories.
        m.directory("static_scaffold")

        # Model
        m.template(
              "generator_specs.rb",
              File.join('static_scaffold',"generator_specs.rb"))
        m.template(
            "model_gen_specs.rb",
            File.join('static_scaffold',"#{@controller_singular_name.underscore.downcase}_gen_specs.rb"))

    end
  end

  protected
    # Override with your own usage banner.
    def banner
      "Usage: #{$0} static_gen_specs ModelName [table_name]"
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
    
    def columns
        ActiveRecord::Base.connection.columns(table_name)    
    end

    def table_name
        if @args and @args.length>=1
            return @args.first
        else
            return @controller_plural_name
        end
    end

end
