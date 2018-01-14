class RenameUsersToOwners < ActiveRecord::Migration
  def change
    rename_table :users, :owners
  end
end
