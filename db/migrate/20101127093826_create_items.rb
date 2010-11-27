class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :title
      t.string :description
      t.float :price
      t.string :status
      t.integer :sale_id

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
