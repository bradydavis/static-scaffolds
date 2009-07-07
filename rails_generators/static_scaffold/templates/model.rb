class <%= class_name %> < ActiveRecord::Base

<%if gen_spec.file_columns and gen_spec.file_columns.length>0 -%>
<%for column,options in gen_spec.file_columns -%>
<%if options[:access]==:private -%>
  has_attached_file <%=column.inspect%>, 
     :url => "/<%=gen_spec.plural_name%>/attachment/:attachment/:id/:style/:basename.:extension",  
     :path => "<%=gen_spec.paperclip_private_root_path%><%=":custom_root_path/" if gen_spec.paperclip_custom_root_path_code%>:attachment/:id/:style/:basename.:extension"
<%else -%>
  has_attached_file <%=column.inspect%>, 
     :url => "/system/:attachment/:id/:style/:basename.:extension",  
     :path => "<%=gen_spec.paperclip_public_root_path%><%=":custom_root_path/" if gen_spec.paperclip_custom_root_path_code%>:attachment/:id/:style/:basename.:extension"
<%end -%>

<%end -%>
<%if gen_spec.paperclip_custom_root_path_code -%>
  def paperclip_custom_root_path
    <%=gen_spec.paperclip_custom_root_path_code%>
  end
<%end -%>

<%end -%>
<%if gen_spec.belongs_to.length>0 -%>
<%for bt in gen_spec.belongs_to -%>
  belongs_to <%=bt[:name].inspect%>, :class_name=><%=bt[:model].inspect%>, :foreign_key=><%=bt[:key].inspect%>
<%end -%>

<%end -%>
<%if gen_spec.has_many.length>0 -%>
<%for hm in gen_spec.has_many -%>
  has_many <%=hm[:name].inspect%>, :class_name=><%=hm[:model].inspect%>, :foreign_key=><%=hm[:key].inspect%>
<%end -%>

<%end -%>
  def self.table_name() 
    "<%=gen_spec.table_name%>" 
  end
  
  def icon
      "<%=gen_spec.singular_name%>.gif"
  end
  
  def short_name
      name = "<%=gen_spec.short_name_columns.map{|c| "\#{@#{c}}"}.join(" ")%>"
      if name==""
          return "Untitled"
      else
          return name
      end
  end
  
  def order_preference
    "<%=gen_spec.order_preference_columns.join(", ")%> <%=gen_spec.order_preference%>" 
  end

<%if gen_spec.ascendant -%>
  def ascendant
    <%=gen_spec.ascendant[:name]%>  
  end

<%end -%>

  # Security / Authorization
  
<%if gen_spec.authorization_method.to_s == 'static_authorization' -%>
  def permits?(user)
    if user.has_global_permit_for(<%=gen_spec.plural_name.inspect%>)
      return true
    else
<%if gen_spec.ascendant -%>
      return (permitted_include?(user) and ascendant.permits?(user))
<%else -%>
      return permitted_include?(user)
<%end -%>
    end
  end

  def permitted_include?(user)
    # Asside from ascendant constraints, is this user permitted to access this <%=gen_spec.singular_name%>
    return true
  end

<%end -%>
end

