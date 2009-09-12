class FixComputers < ActiveRecord::Migration
  def self.up
    add_column :users, :id, :primary_key
    remove_column :computers, :primary_key
    add_column :computers, :id, :primary_key
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
