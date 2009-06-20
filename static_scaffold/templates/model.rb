class <%= class_name %> < ActiveRecord::Base
def self.table_name() "<%=gen_spec.table_name%>" end
end