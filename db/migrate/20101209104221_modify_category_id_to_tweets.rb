class ModifyCategoryIdToTweets < ActiveRecord::Migration
  def self.up
    remove_column :tweets, :category_id
    add_column :tweets, :category_id, :integer, :default => -1
  end

  def self.down
    remove_column :tweets, :category_id
    add_column :tweets, :category_id, :integer
  end
end
