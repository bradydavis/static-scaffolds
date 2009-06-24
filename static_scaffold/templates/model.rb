class <%= class_name %> < ActiveRecord::Base
def self.table_name() "<%=gen_spec.table_name%>" end

<%if gen_spec.authorize_method== :static_authorization -%>
    def authorize(user)
<%if gen_spec.parent -%>
        user.authorize_any(<%=gen_spec.singular.inspect%>) or (<%=gen_spec.singular_name%>_authorize(user) and parent.authorize(user))
<%else -%>
        user.authorize_any(<%=gen_spec.singular.inspect%>) or (<%=gen_spec.singular_name%>_authorize(user) and <%=gen_spec.parent["name"]%>.authorize(user))
<%end -%>
    end

    def <%=gen_spec.singular_name%>_authorize
        return true
    end
<%end -%>
    
    
end