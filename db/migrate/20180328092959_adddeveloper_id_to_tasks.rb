class AdddeveloperIdToTasks < ActiveRecord::Migration[5.1]
  def change
  	add_column :tasks, :developer_id, :integer
  	add_column :tasks, :tester_id, :integer
	add_index  :tasks, :developer_id
	add_index  :tasks, :tester_id
  end
end
