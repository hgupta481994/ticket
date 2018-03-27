class DropRequriementUserTable < ActiveRecord::Migration[5.1]
  def change
  	drop_table :requirements_users
  end
end
