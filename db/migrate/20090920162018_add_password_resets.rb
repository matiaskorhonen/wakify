class AddPasswordResets < ActiveRecord::Migration
  def self.up
    add_column :users, :password_reset, :string
  end

  def self.down
    remove_column :users, :password_reset
  end
end
