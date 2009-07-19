class FacetedSearch::Facet
  
  # facilitate complex queries by managing session data from request paramaters
  
  attr_reader :title
  
  def initialize()
    raise Exception.new("initialize is a subclase responsibility")
  end  

  def turn_off_param
    raise Exception.new("turn_off_param is a subclass responsibility")
  end

  def is_active?
    raise Exception.new("is_on? is a subclass responsibility")
  end
  
  def turn_off
    raise Exception.new("turn_off is a subclass responsibility")
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
  
  def turn_off_if_needed(params)
    if params.keys.include?(turn_off_param) and is_active?
      turn_off
      return true
    else
      return false
    end
  end
  
  def update_with(params)
    value_changed = turn_off_if_needed(params)
    for p in parameter_names
      if params[p]!=nil and @session[p]!=params[p]
        value_changed=true
        @session[p] = params[p]
      end
    end
    return value_changed
  end
  
end