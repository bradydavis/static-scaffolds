module ApplicationHelper
    
def data_table_start(name='zebra')
    "<table class='sortable' id='#{name}'>"
end

def data_table_end(name='zebra')
     "</table> <script>stripe('#{name}','#fff', '#edf3fe');</script>"
end

def standard_date(d)
  if d
   d.strftime("%Y/%m/%d %H:%M")
  else
   nil
  end
end

end