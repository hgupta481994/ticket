class CreateTeamleads < ActiveRecord::Migration[5.1]
  def change
    create_table :teamleads do |t|
      t.string :username

      t.timestamps
    end
  end
end
