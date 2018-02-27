class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.date :start
      t.date :end
      t.string :status

      t.timestamps
    end
  end
end
