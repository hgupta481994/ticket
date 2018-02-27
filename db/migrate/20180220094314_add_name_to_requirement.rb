class AddNameToRequirement < ActiveRecord::Migration[5.1]
  def change
    add_column :requirements, :name, :string
    add_column :requirements, :description, :text
  end
end
