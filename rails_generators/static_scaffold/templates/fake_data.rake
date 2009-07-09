namespace :db do
  desc "Add fake data to <%=gen_spec.plural_name%>"
  require 'active_record'
  require 'populator'
  require 'faker'
  
  task :populate_fake_<%=gen_spec.plural_name%> => :environment do
    <%=gen_spec.model_name%>.populate 2000, :per_query=>1 do |<%=gen_spec.singular_name%>|
<%for attribute,options in gen_spec.column_specs -%>
<%case options[:type] -%>
<%when :integer -%>
      <%=gen_spec.singular_name%>.<%=attribute%> = 10..10000
<%when :text -%>
      <%=gen_spec.singular_name%>.<%=attribute%> = Populator.sentences(2..5)
<%when :string -%>
<%if "first_name last_name firstname lastname fname lname full_name fname fullname".split.select {|x| attribute.to_s.match(x)}.first -%>
      <%=gen_spec.singular_name%>.<%=attribute%> = Faker::Name.name
<%match=true -%>
<%end -%>
<%if "username login login_name".split.select {|x| attribute.to_s.match(x)}.first -%>
      <%=gen_spec.singular_name%>.<%=attribute%> = Faker::Name.name.split.join.underscore.downcase
<%match=true -%>
<%end -%>
<%if "company firm organization agency employer school".split.select {|x| attribute.to_s.match(x) or (attribute.to_s=="name" and gen_spec.singular_name.to_s.match(x))}.first -%>
      <%=gen_spec.singular_name%>.<%=attribute%> = Faker::Company.name
<%match=true -%>
<%end -%>
<%if "email".split.select {|x| attribute.to_s.match(x)}.first -%>
      <%=gen_spec.singular_name%>.<%=attribute%> = Faker::Internet.name
<%match=true -%>
<%end -%>
<%if "phone cell pager".split.select {|x| attribute.to_s.match(x)}.first -%>
      <%=gen_spec.singular_name%>.<%=attribute%> = Faker::PhoneNumber.phone_number
<%match=true -%>
<%end -%>
<%if "street address".split.select {|x| attribute.to_s.match(x)}.first -%>
      <%=gen_spec.singular_name%>.<%=attribute%> = Faker::Address.street_address
<%match=true -%>
<%end -%>
<%if "city".split.select {|x| attribute.to_s.match(x)}.first -%>
      <%=gen_spec.singular_name%>.<%=attribute%> = Faker::Address.city
<%match=true -%>
<%end -%>
<%if "state".split.select {|x| attribute.to_s.match(x)}.first -%>
      <%=gen_spec.singular_name%>.<%=attribute%> = Faker::Address.us_state_abbr
<%match=true -%>
<%end -%>
<%if "zip".split.select {|x| attribute.to_s.match(x)}.first -%>
      <%=gen_spec.singular_name%>.<%=attribute%> = Faker::Address.zip_code
<%match=true -%>
<%end -%>
<%if not match -%>
      <%=gen_spec.singular_name%>.<%=attribute%> = Populator.words(2..5)  
<%end -%>
<%when :decimal -%>
      <%=gen_spec.singular_name%>.<%=attribute%> = 100.0*rand 
<%when :float -%>
      <%=gen_spec.singular_name%>.<%=attribute%> = 100.0*rand 
<%when :foreign_key -%>
      <%=gen_spec.singular_name%>.<%=attribute%> = 1..100 
<%when :file -%>
<%when :photo -%>
<%when :datetime -%>
      <%=gen_spec.singular_name%>.<%=attribute%> = 4.months.ago..Time.now
<%when :date -%>
      <%=gen_spec.singular_name%>.<%=attribute%> = 4.months.ago..Time.now 
<%end -%>
<%end -%>
    end
  end
end