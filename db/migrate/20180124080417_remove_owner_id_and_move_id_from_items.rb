class RemoveOwnerIdAndMoveIdFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :owner_id, :integer
    remove_column :items, :move_id, :integer
  end
end
