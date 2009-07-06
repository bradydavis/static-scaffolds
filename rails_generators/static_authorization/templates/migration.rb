class StaticAuthentication < ActiveRecord::Migration

  def self.up
    create_table :roles do |t|
      t.string :name
      t.boolean :is_super
    end
    
    create_table :permitted_actions do |t|
      t.integer :role_id
      t.string :controller, :action
    end

    create_table :permitted_scopes do |t|
      t.integer :role_id
      t.integer :model_name, :scope
    end
    
  end

  def self.down
    drop_table :roles
    drop_table :permitted_actions
    drop_table :permitted_scopes
  end

end
