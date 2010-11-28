class AddQuestionIdToTweets < ActiveRecord::Migration
  def self.up
    add_column :question_id, :tweets, :integer
  end

  def self.down
    remove_column :question_id, :tweets, :integer
  end
end
