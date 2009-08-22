class <%=gen_spec.model_name%>Search < FacetedSearch::Base
  
  attr_reader <%=gen_spec.search_facets.map {|f| f[:name].to_sym.inspect}.join(", ")%>
  
  def initialize(session,context)
    @session = session
    @context = context  
    @model = <%=gen_spec.model_name%>
    @default_page_size=20
    @max_page_size=500
<%for f in gen_spec.search_facets -%>
    @<%=f[:name]%> = create_<%=f[:type]%>(<%=f[:attributes].inspect%>)
<%end -%>
  end

end