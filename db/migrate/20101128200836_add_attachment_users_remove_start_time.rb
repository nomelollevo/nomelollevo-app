class AddAttachmentUsersRemoveStartTime < ActiveRecord::Migration
  def self.up
    add_column :items, :photo_file_name,    :string
    add_column :items, :photo_content_type, :string
    add_column :items, :photo_file_size,    :integer
    add_column :items, :photo_updated_at,   :datetime

    remove_column :items, :start_time
  end

  def self.down
    remove_column :items, :photo_file_name
    remove_column :items, :photo_content_type
    remove_column :items, :photo_file_size
    remove_column :items, :photo_updated_at

    add_column :items, :start_time, :date
  end
end
