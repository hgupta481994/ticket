class ChangeColumnTeamleadIdToUser < ActiveRecord::Migration[5.1]
  def change
  	change_column :users, :teamlead_id, :integer, :default => 1
  end
end
