class AddNameColumnToComputers < ActiveRecord::Migration
  def self.up
    add_column :computers, :name, :string
  end

  def self.down
    remove_column :computers, :name
  end
end
