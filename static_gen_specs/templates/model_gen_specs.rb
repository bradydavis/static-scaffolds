class <%=class_name%>GenSpecs < GeneratorSpecs
    
    def table_name
        "<%=table_name%>"
    end

    def belongs_to
        model_names = [<%for bt in belongs_to_columns -%><%=bt.name.slice(0,bt.name.length-3).inspect%>,<%end -%>]      
        return gen_specs_for(model_names)
    end

    def parent
        # Specify 1 or no models as the parent.  Scaffolded code will only create this model in the context of its parent
    end

    def has_many
        # Specify the has_many models
    end
    
    def children
        # Specify a subset of the has_many models that are children.
        selected_children = [
                    "",
                    ""
                    ]
        return gen_specs_for(selected_children)
    end
    
    def included_models
        # Specify models to preload
    end
    
    def listed_columns
        # Typically its a good idea to display only a subset of columns in a list.  Comment out the ones to remove from list views.
    end
    
    def form_groups
        # For usability sake, it may be a good idea to group fields into chunks.
        group1 = 
    end

    def children
        # Specify the children in this list
        selected_children = [
                    "",
                    ""
                    ]
        return gen_specs_for(selected_children)
    end
    
    

<%keys=[:name, :sql_type, :precision, :type, :default, :limit, :null, :scale] -%>
    # <%=keys.map { |k| k.to_s.ljust( max_length(columns,k)+2) }.join("")%>
    # <%=keys.map { |k| "-"*( max_length(columns,k)) +"  "}.join("") %>
<%for c in columns -%>
    # <%=keys.map {|k| c.send(k.to_s).inspect.ljust( max_length(columns,k)+2)}.join("")%>
<%end -%>
    


end