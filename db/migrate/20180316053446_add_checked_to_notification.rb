class AddCheckedToNotification < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :checked, :boolean, default: :false
  end
end
