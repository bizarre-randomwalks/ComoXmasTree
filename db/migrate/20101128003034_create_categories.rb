# -*- encoding : utf-8 -*-
class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :title
      t.integer :question_id
      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end