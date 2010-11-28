class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.string :title
      t.string :screen_name
      t.integer :status_id
      t.integer :category_id
      t.timestamps
    end
  end

  def self.down
    drop_table :tweets
  end
end
