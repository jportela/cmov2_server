class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :type
      t.string :address
      t.string :city
      t.string :description
      t.integer :price
      t.string :state

      t.timestamps
    end
  end
end
