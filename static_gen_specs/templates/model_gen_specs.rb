class <%=class_name%>GenSpecs < GeneratorSpecs
  attr_accessor :model_name, :class_name, :table_name, :primary_key,
          :plural_label, :singular_label, :plural_title, :singular_title
          
  def initialize()
    model_name = <%=model_name.inspect%>
    table_name = <%=table_name.inspect%>
    primary_key = "id"
    plural_label = <%=model_name.pluralize.humanize.inspect%>
    singular_label = <%=model_name.humanize.inspect%>
    plural_title = <%=model_name.pluralize.titleize.inspect%>
   singular_title = <%=model_name.titleize.inspect%>
  end

  def columns
    {
<%justifier = CodeJustifier.new(columns) -%>
<%justifier.add_parameter {|o| ":#{o.name} => "} -%>
<%justifier.add_parameter {|o| "{:label=>#{label(o.name).inspect}, "} -%>
<%justifier.add_parameter {|o| ":units=>#{units(o.name).inspect}, "} -%>
<%justifier.add_parameter {|o| ":rows=>#{estimate_rows(o.name).inspect}, "} -%>
<%justifier.add_parameter {|o| ":cols=>#{estimate_cols(o.name).inspect}, "} -%>
<%justifier.add_parameter {|o| ":required=>#{(not o.null).inspect}"} -%>
<%for o in columns -%>
     <%=justifier.render(o)%>},
<%end -%>
    }
  end

  def belongs_to
    [
<%justifier = CodeJustifier.new(belongs_to_columns) -%>
<%justifier.add_parameter {|o| ":name=>#{o.name.slice(0,o.name.length-3).inspect}, "} -%>
<%justifier.add_parameter {|o| ":model=>#{o.name.slice(0,o.name.length-3).camelize.inspect}, "} -%>
<%justifier.add_parameter {|o| ":key=>#{o.name.inspect}, "} -%>
<%for o in belongs_to_columns -%>
     {<%=justifier.render(o)%>},
<%end -%>
    ]
  end

  def parent
    # Specify 1 or no models as the parent.  Scaffolded code will only create this model in the context of its parent
    # parent="ModelName"
    # return GenSpecFactory.constantize(parent)
  end

  def has_many
    [
<%justifier = CodeJustifier.new(has_many_columns) -%>
<%justifier.add_parameter {|o| ":name=>#{o[:table].pluralize.inspect}, "} -%>
<%justifier.add_parameter {|o| ":model=>#{o[:table].singularize.camelize.inspect}, "} -%>
<%justifier.add_parameter {|o| ":key=>#{o[:column].inspect}, "} -%>
<%for o in has_many_columns -%>
     {<%=justifier.render(o)%>},
<%end -%>
    ]
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
  
  # These methods are inherited from generator_specs.rb
  
  # model_name - <%=model_name.inspect%>
  # model_file_name - <%=model_name.underscore.inspect%>
  # class_name - <%=class_name.inspect%>
  # controller_class_name - <%="#{model_name.pluralize}Controller".inspect%>
  # controller_file_name - <%="#{model_name.pluralize}Controller".underscore.inspect%>
  # view_folder_name - <%=model_name.underscore.inspect%>


<%keys=[:name, :sql_type, :precision, :type, :default, :limit, :null, :scale] -%>
  # <%=keys.map { |k| k.to_s.ljust( max_length(columns,k)+2) }.join("")%>
  # <%=keys.map { |k| "-"*( max_length(columns,k)) +"  "}.join("") %>
<%for c in columns -%>
  # <%=keys.map {|k| c.send(k.to_s).inspect.ljust( max_length(columns,k)+2)}.join("")%>
<%end -%>
  


end