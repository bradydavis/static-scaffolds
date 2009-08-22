namespace :db do
  desc "Add fake data to <%=gen_spec.plural_name%>"
  require 'active_record'
  require 'populator'
  require 'faker'
  
  companies = [Faker::Company.name,Faker::Company.name,Faker::Company.name,Faker::Company.name,Faker::Company.name,Faker::Company.name]
  word_set = [Populator.words(1..2), Populator.words(1..2), Populator.words(1..2), Populator.words(1..2), Populator.words(1..2), Populator.words(1..2)]
  
  task :populate_fake_<%=gen_spec.plural_name%> => :environment do
    <%=gen_spec.model_name%>.populate 2000, :per_query=>1 do |<%=gen_spec.singular_name%>|
<%for attribute,options in gen_spec.column_specs -%>
<%case options[:type] -%>
<%when :integer -%>
      <%=gen_spec.singular_name%>.<%=attribute%> = 10..45
<%match=true -%>      
<%when :text -%>
      <%=gen_spec.singular_name%>.<%=attribute%> = Populator.sentences(2..5)
<%match=true -%>      
<%when :string -%>
<%if "full_name fullname".split.select {|x| attribute.to_s.match(x)}.first -%>
      <%=gen_spec.singular_name%>.<%=attribute%> = Faker::Name.name
<%match=true -%>
<%end -%>
<%if "first_name fname firstname f_name".split.select {|x| attribute.to_s.match(x)}.first -%>
      <%=gen_spec.singular_name%>.<%=attribute%> = Faker::Name.first_name
<%match=true -%>
<%end -%>
<%if "last_name lname lastname l_name maiden_name".split.select {|x| attribute.to_s.match(x)}.first -%>
      <%=gen_spec.singular_name%>.<%=attribute%> = Faker::Name.last_name
<%match=true -%>
<%end -%>
<%if "username login login_name".split.select {|x| attribute.to_s.match(x)}.first -%>
      <%=gen_spec.singular_name%>.<%=attribute%> = Faker::Internet.user_name
<%match=true -%>
<%end -%>
<%if "company firm organization agency employer school".split.select {|x| attribute.to_s.match(x) or (attribute.to_s=="name" and gen_spec.singular_name.to_s.match(x))}.first -%>
      <%=gen_spec.singular_name%>.<%=attribute%> = companies
<%match=true -%>
<%end -%>
<%if "email".split.select {|x| attribute.to_s.match(x)}.first -%>
      <%=gen_spec.singular_name%>.<%=attribute%> = Faker::Internet.email
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
      <%=gen_spec.singular_name%>.<%=attribute%> = word_set  
<%end -%>
<%match=false -%>
<%when :decimal -%>
  <%if gen_spec.mapping and gen_spec.mapping[:latitude_attr]==attribute%>
    <%=gen_spec.singular_name%>.<%=attribute%> = 34.829+0.1*rand-0.05 
  <%else%>
    <%if gen_spec.mapping and gen_spec.mapping[:longitude_attr]==attribute%>
      <%=gen_spec.singular_name%>.<%=attribute%> = -92.401+0.1*rand-0.05 
    <%else%>
      <%=gen_spec.singular_name%>.<%=attribute%> = 100.0*rand
    <%end%>
  <%end%>
<%when :float -%>
  <%if gen_spec.mapping and gen_spec.mapping[:latitude_attr]==attribute%>
    <%=gen_spec.singular_name%>.<%=attribute%> = 34.829+0.1*rand-0.05 
  <%else%>
    <%if gen_spec.mapping and gen_spec.mapping[:longitude_attr]==attribute%>
      <%=gen_spec.singular_name%>.<%=attribute%> = -92.401+0.1*rand-0.05 
    <%else%>
      <%=gen_spec.singular_name%>.<%=attribute%> = 100.0*rand
    <%end%>
  <%end%>
<%when :foreign_key -%>
      <%=gen_spec.singular_name%>.<%=attribute%> = 1..20 
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