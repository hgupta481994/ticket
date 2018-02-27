class AddNameToAttachement < ActiveRecord::Migration[5.1]
  def change
    add_column :attachements, :name, :string
  end
end
