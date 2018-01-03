class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.integer :owner_id
      t.integer :move_id
      t.string :name
      t.string :location
    end
  end
end
