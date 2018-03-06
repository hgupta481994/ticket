class AddStatusToTasks < ActiveRecord::Migration[5.1]
  def change
    add_reference :tasks, :status, foreign_key: true
  end
end
