class CreateSales < ActiveRecord::Migration
  def self.up
    create_table :sales do |t|
      t.date :start_time
      t.date :end_time
      t.boolean :is_unlimited
      t.string :province
      t.string :zip_code
      t.string :address

      t.timestamps
    end
  end

  def self.down
    drop_table :sales
  end
end
