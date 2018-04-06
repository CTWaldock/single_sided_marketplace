class ChangeUsersDeactivated < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :deactivated, :boolean
    
  end
end
