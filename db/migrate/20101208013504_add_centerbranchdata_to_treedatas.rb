class AddCenterbranchdataToTreedatas < ActiveRecord::Migration
  def self.up
    add_column :treedatas, :currentTweet, :integer, :default => 0
    add_column :treedatas, :centerTweet, :integer, :default => 3
  end

  def self.down
    remove_column :treedatas, :currentTweet
    remove_column :treedatas, :centerTweet    
  end
end
