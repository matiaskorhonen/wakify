class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.integer :user_id
      t.string :user_agent
      t.string :subject
      t.text :message

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
