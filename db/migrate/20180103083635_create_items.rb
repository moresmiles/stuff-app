class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :box_id
      t.integer :move_id
      t.integer :owner_id
      t.string :name
    end
  end
end
