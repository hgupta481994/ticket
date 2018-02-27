class AddUserToTasks < ActiveRecord::Migration[5.1]
  def change
  	add_reference :tasks,        :user,     foreign_key: true
    add_reference :tasks,        :teamlead, foreign_key: true
    add_reference :tasks,        :tasktype, foreign_key: true
    add_reference :users,        :teamlead, foreign_key: true
    add_reference :users,        :usertype, foreign_key: true
    add_reference :requirements, :user,     foreign_key: true
    add_reference :requirements, :teamlead, foreign_key: true
    add_reference :attachements, :task,     foreign_key: true
  end
end
