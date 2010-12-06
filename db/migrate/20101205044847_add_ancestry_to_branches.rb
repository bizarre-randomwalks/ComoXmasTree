# -*- encoding : utf-8 -*-
class AddAncestryToBranches < ActiveRecord::Migration
  def self.up
    add_column :branches, :ancestry, :string
    add_index :branches, :ancestry
  end

  def self.down
    remove_column :branches, :ancestry
    remove_index :branches, :ancestry
  end
end
