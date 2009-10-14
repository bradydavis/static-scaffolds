class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :full_name
      t.string :username
      t.string :password
      t.string :office
      t.string :phone
      t.string :email
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
