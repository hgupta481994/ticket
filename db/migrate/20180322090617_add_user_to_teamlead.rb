class AddUserToTeamlead < ActiveRecord::Migration[5.1]
  def change
    add_reference :teamleads, :user, foreign_key: true
  end
end
