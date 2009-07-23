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

  def get_previous(id, scope=nil)
    scope=default_scope if not scope
    records = paginate(scope)
    for previous,current in records.each_cons(2)
      if current.id==id.to_i
        return previous
      end
    end
    raise Exception.new("record before this page  .... #{records.map {|r| r.id}.inspect} #{id}")
  end
  
  def get_next(id, scope=nil)
    scope=default_scope if not scope
    records = paginate(scope)
    for current,next_record in records.each_cons(2)
      if current.id==id.to_i
        return next_record
      end
    end
    raise Exception.new("record after this page  .... #{records.map {|r| r.id}.inspect} #{id}")
  end

  def create_keyword_facet(title, attributes)
    register(FacetedSearch::KeywordFacet.new(attributes, title, @model.table_name, @session))
  end
  
  def create_numeric_range_facet(title, attribute)
    register(FacetedSearch::NumericRangeFacet.new(attribute, title, @model.table_name, @session))
  end
  
  def create_date_range_facet(title, attribute)
    register(FacetedSearch::DateRangeFacet.new(attribute, title, @model.table_name, @session))
  end

  def refined(scope)
    @facets.each {|facet| scope = facet.refined(scope)}
    return scope
  end
  
  def default_scope
    @model.scoped({})
  end
  
  def paginate(scope=nil)
    scope = default_scope if not scope
    scope = refined(scope)
    return scope.paginate(:page=>page ,:per_page => page_size)
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
    if update_page_size(params)
      @session[page_param]=1  # Ouch
      # TODO be smarter about page change
    end
  end
  
  def active_facets 
    @facets.select {|facet| facet.is_active? }
  end
  
  def turn_off_facets
    @facets.each {|facet| facet.turn_off }
  end
  
  def order
    @session[order_param]
  end
  
  def page
    @session[page_param]
  end
  
  def page_size
     @session[page_size_param] || @default_page_size
  end
  
  def update_page_size(params)
    v=params[page_size_param]
    if params[page_size_param] and v!=@session[page_size_param] and v.to_f<=@max_page_size
      @session[page_size_param]=v
      return true
    else
      return false
    end
  end
  
  def page_size_param
    "#{@model.table_name}_page_size"
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