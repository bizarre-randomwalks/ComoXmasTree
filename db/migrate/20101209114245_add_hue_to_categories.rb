class AddHueToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :huemin, :integer
    add_column :categories, :huemax, :integer
  end

  def self.down
    remove_column :categories, :huemin
    remove_column :categories, :huemax
  end
end
