class DeleteQuestions < ActiveRecord::Migration
  def self.up
    drop_table :questions
  end

  def self.down
    create_table :questions do |t|
      t.string :title

      t.timestamps
    end
  end
end
