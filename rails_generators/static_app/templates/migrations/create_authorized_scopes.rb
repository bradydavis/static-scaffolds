class CreateAuthorizedScopes < ActiveRecord::Migration
  def self.up
    create_table :authorized_scopes do |t|
      t.integer :role_id
      t.string :model_class_name
      t.string :create_scope_key
      t.string :read_scope_key
      t.string :update_scope_key
      t.string :delete_scope_key
      t.string :qc_scope_key
      t.string :t2_scope_key
      t.timestamps
    end
  end

  def self.down
    drop_table :authorized_scopes
  end
end
