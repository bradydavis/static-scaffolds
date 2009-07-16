class FacetedSearch::KeywordFacet < FacetedSearch::Facet
  
  # Scope for like text on specified attributes
  
  def initialize(attributes, table_name, session)
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

  def param_name()
    "#{@table_name}_keyword"
  end
  
  def search_phrase
    @session[param_name]
  end

  def parameter_names
    [param_name]
  end
    
  def form
    "HTML HERE ??!?"
  end
  
end