class AddTreedataToTreedatas < ActiveRecord::Migration
  def self.up
    remove_column :treedatas, :current_parent_id
    add_column :treedatas, :branch_id, :integer
    add_column :treedatas, :currentDepth, :integer
  end

  def self.down
    add_column :treedatas, :current_parent_id, :integer
    remove_column :treedatas, :branch_id
    remove_column :treedatas, :currentDepth
  end
end
