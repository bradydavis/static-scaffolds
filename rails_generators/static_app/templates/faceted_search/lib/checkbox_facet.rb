class FacetedSearch::CheckboxFacet < FacetedSearch::Facet

  # TODO deal with the fact that all items selected is actually is_active=false
    
  def initialize(attribute, title, table_name, session)
    @title = title
    @attribute = attribute
    @table_name = table_name
    @session = session
  end
  
  def selection_options(scope)
    if not @session[initialize_session_param]
      @session[param_name] = find_selection_options(scope)
      @session[initialize_session_param]=true
    end
    find_selection_options(scope) 
  end
  
  def refined(scope)
    if is_active?
      conditions = selections.map {|s| "#{@table_name}.#{@attribute} = ?"}.join(" or ")
      if selections.include?("")
        conditions = "#{conditions} or #{@table_name}.#{@attribute} is NULL"
      end
      scope = scope.scoped :conditions => [conditions, selections].flatten
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
    "#{@table_name}_checkbox_turn_off_#{@attribute}"
  end

  def param_name()
    "#{@table_name}_cbox_#{@attribute}"
  end
  
  def hidden_param()
    "#{@table_name}_cboxh_#{@attribute}"
  end
  
  def initialize_session_param()
    "#{@table_name}_cbox_init_#{@attribute}"
  end  
  
  def selections
    @session[param_name]
  end
  
  def update_with(params)
    value_changed = turn_off_if_needed(params)
    if params[param_name]!=nil and @session[param_name]!=params[param_name]
      value_changed=true
      @session[param_name] = params[param_name]
    end

    # Use the hidden param to determine if no checkboxes were selected
    if params[hidden_param]!=nil and params[param_name]==nil
      @session[param_name] = []
      value_changed=true
    end
    return value_changed
  end  
  
  def parameter_names
    [param_name, hidden_param]
  end
  
  private
  
  def find_selection_options(scope)
    # Disables earger loading, any conditions requring joins should use :joins instead of :include
    items = scope.find(:all, :select=>"distinct #{@table_name}.#{@attribute}", :include=>nil, :order=>"#{@table_name}.#{@attribute} asc")

    # Consolidate empty string and NULL values
    includes_empty_string = false
    results = []
    for i in items
      value = i.send(@attribute)
      if value == nil or value == ""
        results << "" if not includes_empty_string
        includes_empty_string = true
      else
        results << value
      end
    end
    
    return results
  end
  
end