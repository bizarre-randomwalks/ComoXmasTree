class AddPicToTweets < ActiveRecord::Migration
  def self.up
    add_column :tweets, :pic, :string
  end

  def self.down
    remove_column :tweets, :pic
  end
end
