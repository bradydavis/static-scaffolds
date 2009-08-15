require File.join(RAILS_ROOT,"static_scaffold","generator_specs.rb")

class <%=class_name%>GenSpecs < GeneratorSpecs
  attr_accessor :model_name, :class_name, :table_name, :primary_key, :singular_name, :plural_name,
          :plural_label, :singular_label, :plural_title, :singular_title,
          :authentication_method, :authorization_method,
          :order_preference_columns, :order_preference,
          :paperclip_public_root_path, :paperclip_private_root_path, :paperclip_custom_root_path_code, :will_paginate
          
  def initialize()
    @model_name = <%=model_name.inspect%>
    @table_name = <%=table_name.inspect%>
    @primary_key = "id"
    @plural_name = <%=model_name.underscore.downcase.pluralize.inspect%>
    @singular_name = <%=model_name.underscore.downcase.singularize.inspect%>
    @plural_label = <%=model_name.pluralize.humanize.inspect%>
    @singular_label = <%=model_name.humanize.inspect%>
    @plural_title = <%=model_name.pluralize.titleize.inspect%>
    @singular_title = <%=model_name.titleize.inspect%>

    # Security 
    @authentication_method = :AuthLogic                # :none
    @authorization_method  = :static_authorization     # :none
    
    # Order
    @order_preference_columns = <%=guess_ordered_columns.inspect%>
    @order_preference = "ASC"
    
    # Paperclip configuration
    @paperclip_public_root_path = ':rails_root/public/system/'
    @paperclip_private_root_path = ':rails_root/private/' 
    @paperclip_custom_root_path_code = nil # "self.project.project_number" or "self.album_id"
    
    # Pagination
    @will_paginate = true # false
  end
  
  def short_name_columns
     # Specify the columns that constitute the "name" for example ["first_name", "last_name"]
    <%=guess_short_name.map{|c|c.to_sym}.inspect%>
  end
  
  def table_view_columns
    [
<%for c in column_names -%>
<%if guess_list_columns.include?(c) -%>
      <%=c.to_sym.inspect%>,
<%else -%>
    # <%=c.to_sym.inspect%>,
<%end -%>
<%end -%>
    ]
  end
  
  def search_facets
    [
<%for attribute_name in guess_date_range_facets -%>
<%="#" if is_meta_data?(attribute_name)%>      { 
<%="#" if is_meta_data?(attribute_name)%>        :name       => "<%=attribute_name%>_facet",
<%="#" if is_meta_data?(attribute_name)%>        :type       => "date_range_facet",
<%="#" if is_meta_data?(attribute_name)%>        :attributes => <%=attribute_name.inspect%>,
<%="#" if is_meta_data?(attribute_name)%>        :partial    => "date_range_facet",
<%="#" if is_meta_data?(attribute_name)%>        :title      => <%=attribute_name.titleize.inspect%>      
<%="#" if is_meta_data?(attribute_name)%>      },
<%end -%>      
<%if guess_keyword_facets and guess_keyword_facets.length>0 -%>  
      {
        :name       => "keyword_facet",
        :type       => "keyword_facet",
        :attributes => <%=guess_keyword_facets.inspect%>,
        :partial    => "keyword_facet",
        :title      => "Search <%=model_name.pluralize.titleize%>"
      },
<%end -%>
<%for attribute_name in guess_numeric_range_facets -%>
<%="#" if is_meta_data?(attribute_name)%>      { 
<%="#" if is_meta_data?(attribute_name)%>         :name       => "<%=attribute_name%>_facet",
<%="#" if is_meta_data?(attribute_name)%>         :type       => "numeric_range_facet",
<%="#" if is_meta_data?(attribute_name)%>         :attributes => <%=attribute_name.inspect%>,
<%="#" if is_meta_data?(attribute_name)%>         :partial    => "numeric_range_facet",
<%="#" if is_meta_data?(attribute_name)%>         :title      => <%=attribute_name.titleize.inspect%>        
<%="#" if is_meta_data?(attribute_name)%>      },
<%end -%>

    ]
  end

  def form_groups
    [
      {:group_name=>"<%=model_name.titleize%>",
       :attributes=> [
<%for c in column_names -%>
<%if guess_list_columns.include?(c) -%>
                        <%=c.to_sym.inspect%>,
<%else -%>
                      # <%=c.to_sym.inspect%>,
<%end -%>
<%end -%>
                     ]},
#      {:group_name=>"Group 2",
#       :attributes=> [
#                     ]},
    ]     
  end

  def column_specs
    {
<%justifier = CodeJustifier.new(columns) -%>
<%justifier.add_parameter {|o| ":#{o.name} => "} -%>
<%justifier.add_parameter {|o| "{:label=>#{label(o.name).inspect}, "} -%>
<%justifier.add_parameter {|o| ":type=>#{guess_type(o.name).inspect}, "} -%>
<%justifier.add_parameter {|o| ":access=>:private, "} -%>
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

  def nested_by  
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
  
  def nests_many 
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