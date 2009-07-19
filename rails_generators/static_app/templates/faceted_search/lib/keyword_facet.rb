class FacetedSearch::KeywordFacet < FacetedSearch::Facet
  
  # Scope for like text on specified attributes
  
  def initialize(attributes, title, table_name, session)
    @title=title
    @attributes = attributes
    @table_name = table_name
    @session = session
  end
  
  def refined(scope)
    if not search_phrase.blank?
      for word in search_phrase.split
        sql = @attributes.map {|a| "#{@table_name}.#{a} like ?"}.join(" or ")
        values = ["%#{word}%"]*@attributes.length
        scope = scope.scoped :conditions=>[sql,values].flatten
      end
    end
    return scope
  end
  
  def is_active?
    (not search_phrase.blank?)
  end
  
  def turn_off
    @session[param_name]=nil
  end
  
  def turn_off_param
    "#{@table_name}_turn_off_keyword"
  end

  def param_name()
    "#{@table_name}_keyword"
  end
  
  def search_phrase
    @session[param_name]
  end
  
  def title
    search_phrase
  end

  def parameter_names
    [param_name]
  end
    
  def form
    "HTML HERE ??!?"
  end
  
end