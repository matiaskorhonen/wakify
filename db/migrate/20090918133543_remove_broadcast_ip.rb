class RemoveBroadcastIp < ActiveRecord::Migration
  def self.up
    remove_column :computers, :broadcast_ip
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
