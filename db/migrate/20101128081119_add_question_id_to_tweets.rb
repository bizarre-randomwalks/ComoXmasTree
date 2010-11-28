class AddQuestionIdToTweets < ActiveRecord::Migration
  def self.up
    add_column :tweets, :question_id, :integer
  end

  def self.down
    remove_column :tweets, :question_id
  end
end
