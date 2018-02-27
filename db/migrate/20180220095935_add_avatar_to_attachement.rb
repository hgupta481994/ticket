class AddAvatarToAttachement < ActiveRecord::Migration[5.1]
  def change
    add_column :attachements, :avatar, :string
  end
end
