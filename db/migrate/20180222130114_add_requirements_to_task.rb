class AddRequirementsToTask < ActiveRecord::Migration[5.1]
  def change
  	add_reference :tasks,        :requirement,     foreign_key: true
  end
end
