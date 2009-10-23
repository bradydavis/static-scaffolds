# Load all generator specs
#spec_files = Dir.glob(File.join(RAILS_ROOT,"static_scaffold","*.rb"))
#for f in spec_files
#    require f
#end

class GenSpecFactory

    def GenSpecFactory.constantize(mname)
        if mname.type==Array
            return mname.flatten.map {|m| GenSpecFactory.constantize(m) }
        else
            # Instantiate the GenSpec based on model name
            mname = model_name if not mname
            gen_specs_mname = "#{mname}GenSpecs"
            Object::const_get(gen_specs_mname).new()
        end
    end
end


class GeneratorSpecs < GenSpecFactory
    
    def additional_route_actions
      if route_collection
        ", :collection=>#{route_collection.inspect}"
      else
        ""
      end
    end
    
    def route_collection
      collections={}
      if mapping
        collections=collections.merge({:map=>:get})
      end
      return collections
    end
        
    def nested_by_gen_spec
      GenSpecFactory.constantize(nested_by[:model])
    end
    
    def form_for_obj
      if nested_by and nested_by.length>0
        return "[@#{nested_by_gen_spec.singular_name},@#{singular_name}]"
      else
        return "@#{singular_name}"
      end
    end
    
    def collection_route
      if nested_by and nested_by.length>0
        "#{nested_by_gen_spec.singular_name}_#{plural_name}_path(@#{nested_by_gen_spec.singular_name})"
      else
        "#{plural_name}_path"
      end
    end
    
    def resource_route
      if nested_by and nested_by.length>0
        "#{nested_by_gen_spec.singular_name}_#{singular_name}_path(@#{nested_by_gen_spec.singular_name})"
      else
        "#{singular_name}_path"
      end
    end    
    
    def nested_by_columns
      # Its only one, but a list is easy to work with
      if nested_by
        [nested_by[:key]]
      else
        []
      end
    end
    
    def root_resource
      # returns the gen spec of the root resource of nested resources
      root_resources.last
    end
    
    def resource_crumbtrail
      # returns a list of gen specs for the nested resources where the current resource is last
      root_resources.reverse
    end
    
    def root_resources
      # returns a list of gen specs for the nested resources where the current resource is first
      if @cached_root_resources
        return @cached_root_resources
      else
        @cached_root_resources = GenSpecFactory.constantize(root_resources_helper)
        return @cached_root_resources
      end
    end
    
    def root_resources_helper
      # build model name list of root resources
      if nested_by
        return [model_name]+GenSpecFactory.constantize(nested_by[:model]).root_resources_helper 
      else
        return [model_name]
      end
    end
    
    def file_columns
      column_specs.select {|k,v| v[:type]==:file or v[:type]==:photo}
    end

    def safe_form_groups
      form_groups.map {|group| {:group_name=>group[:group_name], :attributes=>(group[:attributes]-nested_by_columns-primary_columns)}}
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