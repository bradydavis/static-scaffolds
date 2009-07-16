class FacetedSearch::Facet
  
  # facilitate complex queries by managing session data from request paramaters
  
  def initialize(table_name,session)
    @session = session
    @table_name = table_name
    raise Exception.new("initialize is a subclase responsibility")
  end  

  def refined
    raise Exception.new("refine is a subclass responsibility")
  end

  def parameter_names
    raise Exception.new("parameter_names is subclass responsibility")
  end

  def to_params
    params = {}
    parameter_names.each {|pname| params[pname]=@session[pname]}
    return params
  end
  
  def update_with(params)
    parameter_names.each {|p| @session[p] = params[p] unless params[p]==nil}
  end
  
end