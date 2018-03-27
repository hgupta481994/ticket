class DeleteUserIdToRequirement < ActiveRecord::Migration[5.1]
  def change
  	remove_column :requirements, :user_id
  end
end
