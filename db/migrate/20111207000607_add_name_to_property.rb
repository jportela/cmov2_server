class AddNameToProperty < ActiveRecord::Migration
  def self.up
    add_column :properties, :name, :string
  end

  def self.down
    remove_column :properties, :name
  end
end
