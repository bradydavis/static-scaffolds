class FilterSessionBase
  
  # See Ryan Bates Episode 112 & 119
  
  def initialize(session)
    @session = session
  end

  def numeric_range_filters
    []
  end
  
  def keyword_filters
    []
  end
  
  def belongs_to_filters
    []
  end
  
  def select_filters
    []
  end

  def find_clients
    scope = Product.scope({})
    numeric_range_filters.each { |a| scope = numeric_range_scope(scope, a) }
    belongs_to_filters.each    { |a| scope = belongs_to_filters_scope(scope, a) }
    select_filters.each        { |a| scope = select_filters_scope(scope, a) }
    scope = keyword_filters unless keyword_filters.blank?
    scope
  end

  def update_filter(params)
    @params=params
    update_page_and_order()
    update_numeric_range_filter("price")
  end
  
  private
  
  def reset
    @session[@prefix] = {}
    set("order_by","price")
    set("order", "asc")
  end
  
  def numeric_range_scope(scope, attribute)
    lr = session[@prefix]["#{lower_range}_#{attribute}"]
    ur = session[@prefix]["#{upper_range}_#{attribute}"]
    scope.scoped :conditions => ["#{Client.table_name}.#{attribute} >= ?", lr] unless lr.blank?
    scope.scoped :conditions => ["#{Client.table_name}.#{attribute} <= ?", ur] unless ur.blank?
  end
  
  def update_page_and_order(params)
    @params=params
    set_if("page")
    set_if("order_by")
    set_if("order")
  end
  
  def update_numeric_range_filter(attribute)
    set_if("upper_range_#{attribute}", @params)
    set_if("lower_range_#{attribute}", @params)
  end
  
  def set_if(attribute, params)
    @session[@prefix][name] = params[attribute]) unless params[attribute].blank?
  end
    
end