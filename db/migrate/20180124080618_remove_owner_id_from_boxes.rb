class RemoveOwnerIdFromBoxes < ActiveRecord::Migration
  def change
    remove_column :boxes, :owner_id, :integer
  end
end
