# -*- encoding : utf-8 -*-
class AddDateToTweets < ActiveRecord::Migration
  def self.up
    add_column :tweets, :month, :integer, :default => 0
    add_column :tweets, :day, :integer, :default => 0
  end

  def self.down
    remove_column :tweets, :month
    remove_column :tweets, :day
  end
end
