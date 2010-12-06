# -*- encoding : utf-8 -*-
class CreateBranchconnections < ActiveRecord::Migration
  def self.up
    create_table :branchconnections do |t|
      t.integer :brancher_id
      t.integer :branchee_id
      t.timestamps
    end
  end

  def self.down
    drop_table :branchconnections
  end
end
