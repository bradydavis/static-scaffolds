class <%= class_name %> < ActiveRecord::Base
def self.table_name() "<%=gen_spec.table_name%>" end

<%if gen_spec.ascendant -%>
    def ascendant
        <%=gen_spec.singular_name%>  
    end
<%end -%>

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

