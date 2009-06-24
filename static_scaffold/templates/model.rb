class <%= class_name %> < ActiveRecord::Base

  PUBLIC_ROOT_PATH = <%=gen_spec.public_root_path%>
  PRIVATE_ROOT_PATH = <%=gen_spec.private_root_path%>

<%if gen_spec.file_columns.length>0 -%>
<%for column,options in gen_spec.file_columns -%>
  file_column :<%=column.inspect%>, :store_dir=><%="#{column}_store_dir".inspect%>, :root_path=><%if options["public"]%>PUBLIC_ROOT_PATH><%else%>PRIVATE_ROOT_PATH<%end%>
<%end -%>

<%end -%>
<%if gen_spec.belongs_to.length>0 -%>
<%for bt in gen_spec.belongs_to.sort {|a,b|a["name"]<=>b["name"]} -%>
  belongs_to <%=bt[:name].inspect%>, :class_name=><%=bt[:model].inspect%>, :foreign_key=><%=bt[:key].inspect%>
<%end -%>

<%end -%>
<%if gen_spec.has_many.length>0 -%>
<%for hm in gen_spec.has_many.sort {|a,b|a["name"]<=>b["name"]} -%>
  has_many <%=hm[:name].inspect%>, :class_name=><%=hm[:model].inspect%>, :foreign_key=><%=hm[:key].inspect%>
<%end -%>

<%end -%>
  def self.table_name() 
    "<%=gen_spec.table_name%>" 
  end
  
  def icon
      "<%=gen_spec.singular_name%>.gif"
  end
  
  def order_preference
    "<%=gen_spec.order_preference_columns.join(", ")%> <%=gen_spec.order_preference%>" 
  end

<%if gen_spec.ascendant -%>
  def ascendant
    <%=gen_spec.ascendant[:name]%>  
  end

<%end -%>
<%if gen_spec.file_columns -%>
  # File Columns Directory

  def refactored_store_dir
      <%=gen_spec.singular_name.pluralize.inspect%>
  end
<%for column,options in gen_spec.file_columns -%>  
  def <%=column%>_store_dir
      File.join(refactored_store_dir, <%=column.to_s.pluralize.inspect%>)
  end
<%end -%>

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

