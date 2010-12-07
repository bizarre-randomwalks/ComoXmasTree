# -*- encoding : utf-8 -*-
class CreateTreedatas < ActiveRecord::Migration
  def self.up
    create_table :treedatas do |t|
      t.integer :current_parent_id 
      t.timestamps
    end
  end

  def self.down
    drop_table :treedatas
  end
end
