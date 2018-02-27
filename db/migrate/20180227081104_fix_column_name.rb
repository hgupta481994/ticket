class FixColumnName < ActiveRecord::Migration[5.1]
  def self.up
    rename_column :tasktypes, :type, :ttype
  end

  def self.down
    rename_column :tasktypes, :ttype, :type
  end
end
