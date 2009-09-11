class CreateComputers < ActiveRecord::Migration
  def self.up
    create_table :computers do |t|
      t.belongs_to :user
      t.integer :id, :primary_key 
      t.String :name, :null => false
      t.text :description
      t.string :host, :null => false
      t.string :mac, :null => false
      t.string :broadcast_ip

      t.timestamps
    end
  end

  def self.down
    drop_table :computers
  end
end
