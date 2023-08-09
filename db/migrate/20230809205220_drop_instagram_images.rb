class DropInstagramImages < ActiveRecord::Migration[5.2]
  def change
    drop_table :instagram_images
  end
end
