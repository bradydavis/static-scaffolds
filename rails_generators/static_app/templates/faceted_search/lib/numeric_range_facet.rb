class FacetedSearch::NumericRangeFacet < FacetedSearch::Facet
  
  # Set upper and lower limit values for an attribute
  
  def initialize(attribute, table_name, session)
    @attribute = attribute
    @table_name = table_name
    @session = session
  end

  def refined(scope)
    scope = scope.scoped :conditions => ["#{@table_name}.#{@attribute} <= ?", upper_limit] unless upper_limit.blank?
    scope = scope.scoped :conditions => ["#{@table_name}.#{@attribute} >= ?", lower_limit] unless lower_limit.blank?
    return scope
  end

  def upper_limit_param_name()
    "#{@table_name}_nrul_#{@attribute}"
  end
  
  def lower_limit_param_name()
    "#{@table_name}_nrll_#{@attribute}"
  end
  
  def upper_limit
    @session[upper_limit_param_name]
  end
  
  def lower_limit
    @session[lower_limit_param_name]
  end
  
  def parameter_names
    [upper_limit_param_name, lower_limit_param_name]
  end
    
  def form
    "HTML HERE ??!?"
  end
  
end