class FacetedSearch::Base
  
  # Manage a set of Basefacets which facilitate complex 
  # queries by storing search criteria found in request parameters 
  # and recalling these parameters to refine scopes
  
  # See Ryan Bates RailsCast Episodes 112 & 119 for an explanation of 
  # Anonymous Scopes and Session Models
  
  def initialize(session)
    raise Exception.new("initialize is a subclass responsibility")
  end

  def register(facet)
    @facets = [] if not @facets
    @facets << facet
    return facet
  end

  def create_keyword_facet(attributes)
    register(FacetedSearch::KeywordFacet.new(attributes, @model.table_name, @session))
  end
  
  def create_numeric_range_facet(attribute)
    register(FacetedSearch::NumericRangeFacet.new(attribute, @model.table_name, @session))
  end
  
  def create_date_range_facet(attribute)
    register(FacetedSearch::DateRangeFacet.new(attribute, @model.table_name, @session))
  end

  def refined(scope)
    @facets.each {|facet| scope = facet.refined(scope)}
    return scope
  end
  
  def paginate(scope=nil)
    scope = @model.scoped({}) if not scope
    scope = refined(scope)
    return scope.paginate({:page=>page})
  end
  
  def to_params
    params={}
    @facets.each {|facet| params.merge(facet.to_params) }
    return params
  end
  
  def to_md5
    require 'digest/md5'
    Digest::MD5.hexdigest(to_params.to_s)
  end

  def update_with(params)
    if @facets.map {|facet| facet.update_with(params)}.include?(true)
      @session[page_param]=1  # Parameter of search changed.  Start over at page 1
    else
      @session[page_param] = params[page_param] unless params[page_param].blank?
    end
  end
  
  def order
    @session[order_param]
  end
  
  def page
    @session[page_param]
  end
   
  def order_param
    "#{@model.table_name}_order"
  end

  def order_by_param
    "#{@model.table_name}_order_by"
  end

  def page_param
    "#{@model.table_name}_page"
  end


end