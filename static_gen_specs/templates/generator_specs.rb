class GeneratorSpecs
    
    def table_name
        raise Exception("table_name method not implimented.")
    end
    
    def columns
        ActiveRecord::Base.connection.columns(table_name)    
    end
    
    def small_icon
        "small_icon_#{table_name}.gif"
    end
    
end