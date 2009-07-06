class StaticAuthenticationGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m| 
        # Check for class naming collisions.
        m.class_collisions("#{controller_class_name}Controller", "#{controller_class_name}Helper")
        m.class_collisions(class_name)

        # Controller, helper, views, test and stylesheets directories.
        m.directory("static_scaffold")

        # Migration
        m.template(
              "migration.rb",
              File.join('db','migrate',"#{Time.now.strftime("%Y%m%d%H%M%S")}_static_authentication.rb"))
    end
  end
  
  def user_foreign_key
      # if they pass in Users as an option ... return user_id
  end
end