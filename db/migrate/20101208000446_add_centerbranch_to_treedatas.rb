class AddCenterbranchToTreedatas < ActiveRecord::Migration
  def self.up
    add_column :treedatas, :centerbranch_id, :integer
  end

  def self.down
    remove_column :treedatas, :centerbranch_id
  end
end
