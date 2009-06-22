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
    
    def belongs_to_columns
        # return columns indending in '_id'
        columns.select {|c| c.name.slice(-3,3)=="_id"}
    end
    
    def has_many_columns
        # search other tables for foreign keys, match based on naming convention
        # for example: friend_user_id would be assumed to be a foreign key to a User
        results = []
        tables = ActiveRecord::Base.connection.tables
        ref_id = "#{model_name.underscore.singularize.downcase}_id"
        print "ref_id=#{ref_id}"
        for t in tables
            for c in ActiveRecord::Base.connection.columns(t)
                if c.name.slice(0-ref_id.length,ref_id.length)==ref_id
                    results << {:table=>t, :column=>c.name}
                end
            end
        end
        return results
    end
    
    # a helper method
    
    def max_length(objects, method)
        (objects.map {|item| item.send(method.to_s).inspect.length} << method.to_s.length).max
    end
    
    def column(col_name)
        columns.select {|c| c.name==col_name }.first
    end
        
    def estimate_cols(cname)
        c=column(cname)
        case c.type
        when :text then 30
        when :integer then
            if belongs_to_columns.map {|bt| bt.name}.select {|name| name==cname}.first
                30
            else
                5
            end
        when :datetime then 18
        when :float then 8
        when :string then estimate_string(cname)
        else 30
        end
    end
    
    def estimate_rows(cname)
        c=column(cname)
        case c.type
        when :text then 3
        else 1
        end
    end
    
    def estimate_string(cname)
        # Look for commonly named fields and guess length otherwise make an educated guess based on db limits
        c=column(cname)
        common_lengths = { "phone"=>15,"fax"=>15, "zip"=>12, "first_name"=> 15, "last_name"=>15 }
        key=common_lengths.keys.select {|key| cname[key]}.first
        if key
            common_lengths[key]
        else
            case c.limit
            when 0..15
                c.limit
            when 15..30
                20
            else
                30
            end
        end
    end
    
    def guess_alignment(cname)
        c=column(cname)
        case c.type
        when :integer
            if belongs_to_columns.map {|bt| bt.name}.select {|name| name==cname}.first
                "left"
            else
                "right"
            end
        when :float
            "right"
        when :decimal
            "right"
        else
            "left"
        end
    end
    
    def guess_decimals(cname)
        c=column(cname)
        case c.type
        when :integer
            if belongs_to_columns.map {|bt| bt.name}.select {|name| name==cname}.first
                nil
            else
                0
            end
        when :float
            3
        when :decimal
            3
        else
            nil
        end
    end
    
    # the idea here is to guess at whate columns should be included in the list/table view
    # the anticipation is that some columns will be hidden by default
    
    def guess_in_list(cname)
        c=column(cname)
        if c.type==:text
            return false
        end
        hidden_fields = "password guid".split
        for h in hidden_fields
            if cname.match(h)
                return false
            end
        end

        return true
    end
    
    # units helpers - the idea is to encourage folks to append their units to the end of their db column names
    
    def units_hash
        {
            "_hrs" => "hours",
            "_hours"=>"hours",
            "_min"=>"minutes",
            "_minutes"=>"minutes",
            "_ppm"=>"ppm",
            "_ppb"=>"ppb",
            "_mgm3"=>"mg/m3",
            "_f"=>"&deg;f",
            "_c"=>"&deg;c",
            "_rh"=>"% rh",
            "_utf"=>""
        }
    end
    
    def units(cname)
        u=units_hash[units_key(cname)]
        if u
            u
        else
            nil
        end
    end
    
    def label(cname)
        ukey = units_key(cname)
        if ukey
            cname.slice(0,cname.length-ukey.length).titleize
        else
            cname.titleize
        end
    end
    
    def units_key(cname)
        units_hash.keys.select {|k| cname.slice((0-k.length),k.length)==k }.first
    end
    
    
    
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

    def render(object)
        self.parameters.map {|p| p.call(object).ljust(max_length(p))}.join("")
    end

    def max_length(parameter)
        self.objects.map {|o| parameter.call(o).to_s.length }.max
    end
end
