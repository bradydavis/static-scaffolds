class <%= class_name %> < ActiveRecord::Base
def self.table_name() "<%=gen_spec.table_name%>" end

<%if gen_spec.authorize_method== :static_authorization -%>
    def authorize_scope(user)
<%if gen_spec.parent -%>
        user.authorize_global_access(<%=gen_spec.singular.inspect%>) 
        or (<%=gen_spec.singular_name%>_authorize_scope(user) and <%=gen_spec.parent["name"]%>.authorize_scope(user))
<%else -%>
        user.authorize_global_access(<%=gen_spec.singular.inspect%>) or <%=gen_spec.singular_name%>_authorize_scope(user)
<%end -%>
    end

    def <%=gen_spec.singular_name%>_authorize_scope(user)
        # Impliment custom scoping rules here
        return true
    end
<%end -%>
    
    
end