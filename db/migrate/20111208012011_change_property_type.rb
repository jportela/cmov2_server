class ChangePropertyType < ActiveRecord::Migration
  def up
    rename_column :properties, :type, :ptype
  end

  def down
    rename_column :properties, :ptype, :type
  end
end
