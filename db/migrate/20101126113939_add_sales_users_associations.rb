class AddSalesUsersAssociations < ActiveRecord::Migration
  def self.up
    add_column :sales, :user_id, :integer
    add_column :sales, :longitude, :float
    add_column :sales, :latitude, :float
  end

  def self.down
    remove_column :sales, :user_id
  end
end
