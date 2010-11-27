class AddCategoryToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :category, :string
  end

  def self.down
    remove_column :items, :category
  end
end
