class CreateRequriementUserTable < ActiveRecord::Migration[5.1]
  def change
    create_table :requirements_users do |t|
      t.belongs_to :user, index: true
      t.belongs_to :requirement, index: true
    end
  end
end
