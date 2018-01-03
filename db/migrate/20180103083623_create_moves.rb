class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.integer :owner_id
      t.string :origin
      t.string :destination
      t.date :move_date
    end
  end
end
