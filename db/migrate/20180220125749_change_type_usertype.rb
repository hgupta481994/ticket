class ChangeTypeUsertype < ActiveRecord::Migration[5.1]
  def change
  	rename_column :usertypes, :type, :utype
  end
end
