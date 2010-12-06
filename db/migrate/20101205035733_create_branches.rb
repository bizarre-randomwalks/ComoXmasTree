# -*- encoding : utf-8 -*-
class CreateBranches < ActiveRecord::Migration
  def self.up
    create_table :branches do |t|
      t.float :scale
      t.float :y
      t.float :rotation
      t.float :length
      t.integer :tweet_id
      t.timestamps
    end
  end

  def self.down
    drop_table :branches
  end
end
