# Load all generator specs
spec_files = Dir.glob(File.join(RAILS_ROOT,"static_scaffold","*.rb"))
for f in spec_files
    load f
end

class GenSpecFactory

    def GenSpecFactory.constantize(mname)
        if mname.type==Array
            return mname.map {|m|m.constantize_gen_spec}
        else
            # Instantiate the GenSpec based on model name
            mname = model_name if not mname
            gen_specs_mname = "#{mname}GenSpecs"
            Object::const_get(gen_specs_mname).new()
        end
    end
end


class GeneratorSpecs < GenSpecFactory
    
    
    def table_name
        raise Exception("table_name method not implimented.")
    end
    
    def schema
        ActiveRecord::Base.connection.columns(table_name)    
    end
    
    def small_icon
        "small_icon_#{table_name}.gif"
    end
    
    def model_file_name
         # <%=model_name.underscore.inspect%>
         model_name.underscore
    end

    def controller_class_name
        # <%="#{model_name.pluralize}Controller".inspect%>
        "#{model_name.pluralize}Controller"
    end
    
    def controller_file_name
        # "<%="#{model_name.pluralize}Controller".underscore.inspect%>"
        "#{model_name.pluralize}Controller".underscore
    end
    
    def view_folder_name
        # <%=model_name.underscore.inspect%> 
        model_name.pluralize.underscore
    end

    
end


    
end