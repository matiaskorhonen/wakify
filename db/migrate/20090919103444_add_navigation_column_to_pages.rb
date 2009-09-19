class AddNavigationColumnToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :navigation, :boolean, :default => false
  end

  def self.down
    remove_column :pages, :navigation
  end
end
