class CreateRequirementsUsersJoinTable < ActiveRecord::Migration[5.1]
  def change
  	
	create_join_table :requirements, :users do |t|
    t.index :requirement_id
    t.index :user_id
	end
  end
end
