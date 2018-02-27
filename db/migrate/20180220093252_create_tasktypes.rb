class CreateTasktypes < ActiveRecord::Migration[5.1]
  def change
    create_table :tasktypes do |t|
      t.string :type

      t.timestamps
    end
  end
end
