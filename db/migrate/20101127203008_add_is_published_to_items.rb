class AddIsPublishedToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :is_published, :boolean
  end

  def self.down
    remove_column :items, :is_published
  end
end
