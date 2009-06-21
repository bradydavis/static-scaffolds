# Load all generator specs
spec_files = Dir.glob(File.join(RAILS_ROOT,"static_scaffold","*.rb"))
for f in spec_files
    load f
end

class ForeignKey
    attr_writer :name, :foreign_key, :class_name 
    attr_reader :name, :foreign_key, :class_name
    
    def init(name,foreign_key,class_name)
        self.name=name
        self.foreign_key=foreign_key
        self.class_name = class_name
    end
end

class GeneratorSpecs
    
    def table_name
        raise Exception("table_name method not implimented.")
    end
    
    def schema
        ActiveRecord::Base.connection.columns(table_name)    
    end
    
    def small_icon
        "small_icon_#{table_name}.gif"
    end

    def gen_specs_for(mnames)
        # Convert list of model names to a list Instantiated Generator Specs
        mnames.map {|m| gen_spec_for(m)}
    end

    def gen_spec_for(mname=nil)
        # Instantiate the GenSpec based on model name
        mname = model_name if not mname
        gen_specs_mname = "#{mname}GenSpecs"
        Object::const_get(gen_specs_mname).new()
    end
    
end

class GeneratorColumnSpecs
    attr_writer :name, :sql_type, :precision, :type, :default, :limit, :null, :scale
    attr_reader :name, :sql_type, :precision, :type, :default, :limit, :null, :scale
    
    def init(column)
        attributes=[:name, :sql_type, :precision, :type, :default, :limit, :null, :scale]
        for a in attributes
            self.send("#{a=}",column.send("#{a}"))
        end
    end
    
end