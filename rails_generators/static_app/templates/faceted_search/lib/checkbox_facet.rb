class FacetedSearch::CheckboxFacet < FacetedSearch::Facet

    
  def initialize(attribute, title, table_name, session)
    @title = title
    @attribute = attribute
    @table_name = table_name
    @session = session
  end

  def selection_options(scope)
    # Disables earger loading, any conditions requring joins should use :joins instead of :include
    scope.find(:all, :select=>"distinct #{@table_name}.#{@attribute}", :include=>nil, :order=>"#{@table_name}.#{@attribute} asc")
  end

  def refined(scope)
    # TODO deal with NULLs and Empty Strings
    if is_active?
      sql = selections.map {|s| "#{@table_name}.#{@attribute} = ?"}.join(" or ")
      scope = scope.scoped :conditions => [sql, selections].flatten
    end
    return scope
  end

  def is_active?
    (not selections.blank?)
  end
  
  def turn_off
    @session[param_name]=nil
  end

  def turn_off_param
    "#{@table_name}_turn_off_#{@attribute}"
  end

  def param_name()
    "#{@table_name}_nrul_#{@attribute}"
  end
  
  def upper_limit
    @session[upper_limit_param_name]
  end
  
  def selections
    @session[param_name]
  end
  
  def parameter_names
    [param_name]
  end
    
end