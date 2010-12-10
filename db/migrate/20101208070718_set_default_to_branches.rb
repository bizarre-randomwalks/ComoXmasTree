class SetDefaultToBranches < ActiveRecord::Migration
  def self.up
    remove_column :branches, :tweet_id, :integer
    add_column :branches, :tweet_id, :integer, :default => -1
  end

  def self.down
    remove_column :branches, :tweet_id, :integer
    add_column :branches, :tweet_id, :integer
  end
end
