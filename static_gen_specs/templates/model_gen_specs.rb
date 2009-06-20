class <%=class_name%>GenSpecs < GeneratorSpecs
    
    def table_name
        "<%=table_name%>"
    end
    
    def columns
        <%attributes=[:name, :sql_type, :precision, :type, :default, :limit, :null, :scale] -%>
        attributes=<%=attributes.inspect%>
        
        table_columns = [
<%for c in columns -%>
            <%=attributes.map {|a| c.send(a.to_s) }.inspect%>,
<%end-%>
            ]

    end
    

end