class StaticAuthenticationGenerator <  Rails::Generator::Base
  def manifest
    record do |m| 

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