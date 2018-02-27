class AddAvatarToRequirement < ActiveRecord::Migration[5.1]
  def change
    add_column :requirements, :avatar, :string
  end
end
