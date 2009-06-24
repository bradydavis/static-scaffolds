class <%= class_name %> < ActiveRecord::Base
def self.table_name() "<%=gen_spec.table_name%>" end

<%if gen_spec.ascendant -%>
    def ascendant
        <%=gen_spec.singular_name%>  
    end
<%end -%>

<%if gen_spec.authorization_method.to_s == 'static_authorization' -%>
    def authorize_scope(user)
<%if gen_spec.ascendant -%>
        user.authorize_global_access(<%=gen_spec.singular_name.inspect%>) or (<%=gen_spec.singular_name%>_authorize_scope(user) and ascendant.authorize_scope(user))
<%else -%>
        user.authorize_global_access(<%=gen_spec.singular_name.inspect%>) or <%=gen_spec.singular_name%>_authorize_scope(user)
<%end -%>
    end

    def <%=gen_spec.singular_name%>_authorize_scope(user)
        # Impliment custom scoping rules here
        return true
    end

<%end -%>
end