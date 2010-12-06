class AddCacheDepthToBranches < ActiveRecord::Migration
  def self.up
    add_column :branches, :ancestry_depth, :integer, :default => 0
  end

  def self.down
    remove_column :branches, :ancestry_depth
  end
end
