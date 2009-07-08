# Load all generator specs
#spec_files = Dir.glob(File.join(RAILS_ROOT,"static_scaffold","*.rb"))
#for f in spec_files
#    require f
#end

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
    
    def ascendant_columns
      if ascendant
        [ascendant[:key]]
      else
        []
      end
    end
    
    def file_columns
      column_specs.select {|k,v| v[:type]==:file or v[:type]==:photo}
    end

    def safe_form_groups
      form_groups.map {|group| {:group_name=>group[:group_name], :attributes=>(group[:attributes]-ascendant_columns-primary_columns)}}
    end
    
    def safe_table_view_columns
      (table_view_columns - primary_columns - short_name_columns).map {|c| [c,column_specs[c]]}
    end

    def belongs_to_hash(column_name)
      belongs_to.select {|bt| bt[:key].to_s==column_name.to_s}.first
    end
    
    def belongs_to_name(column_name)
      belongs_to_hash(column_name)[:name]
    end

    def belongs_to_model(column_name)
      belongs_to_hash(column_name)[:model]
    end
    
    def primary_columns
      column_specs.keys.select {|k| column_specs[k][:type]==:primary_key }
    end
    
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