class AddPortToComputers < ActiveRecord::Migration
  def self.up
    add_column :computers, :port, :integer
  end

  def self.down
    remove_column :computers, :port
  end
end
