class AddTweetedToBranches < ActiveRecord::Migration
  def self.up
    add_column :branches, :tweeted, :boolean, :default => false
  end

  def self.down
    remove_column :branches, :tweeted
  end
end
