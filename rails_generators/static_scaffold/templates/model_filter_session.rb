class ClientFilterSession < FilterSessionBase
  
  # See Ryan Bates Episode 112 & 119
  
  # it would be cool to set these in a way that had order

  def numeric_range_filters
    ["price","weight"]
  end
  
  def keyword_filters
    ["name", "description"]
  end
  
  def belongs_to_filters
    ["category_id"]
  end
  
  def select_filters
    ["company"]
  end

end