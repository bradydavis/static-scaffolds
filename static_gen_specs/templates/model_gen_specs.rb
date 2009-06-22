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
<%justifier.add_parameter {|o| ":type=>#{guess_type(o.name).inspect}, "} -%>
<%justifier.add_parameter {|o| ":units=>#{units(o.name).inspect}, "} -%>
<%justifier.add_parameter {|o| ":rows=>#{estimate_rows(o.name).inspect}, "} -%>
<%justifier.add_parameter {|o| ":cols=>#{estimate_cols(o.name).inspect}, "} -%>
<%justifier.add_parameter {|o| ":required=>#{(not o.null).inspect}, "} -%>
<%justifier.add_parameter {|o| ":align=>#{guess_alignment(o.name).inspect}, "} -%>
<%justifier.add_parameter {|o| ":decimals=>#{guess_decimals(o.name).inspect}"} -%>
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
<%justifier = CodeJustifier.new(belongs_to_columns) -%>
<%justifier.add_parameter {|o| ":name=>#{o.name.slice(0,o.name.length-3).inspect}, "} -%>
<%justifier.add_parameter {|o| ":model=>#{o.name.slice(0,o.name.length-3).camelize.inspect}, "} -%>
<%justifier.add_parameter {|o| ":key=>#{o.name.inspect}, "} -%>
<%for o in belongs_to_columns -%>
  #  {<%=justifier.render(o)%>}
<%end -%>
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
    [
<%justifier = CodeJustifier.new(has_many_columns) -%>
<%justifier.add_parameter {|o| ":name=>#{o[:table].pluralize.inspect}, "} -%>
<%justifier.add_parameter {|o| ":model=>#{o[:table].singularize.camelize.inspect}, "} -%>
<%justifier.add_parameter {|o| ":key=>#{o[:column].inspect}, "} -%>
<%for o in has_many_columns -%>
   # {<%=justifier.render(o)%>},
<%end -%>
    ]
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