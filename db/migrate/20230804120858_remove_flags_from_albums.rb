class RemoveFlagsFromAlbums < ActiveRecord::Migration[5.2]
  def change
    remove_column :albums, :highlight, :boolean, default: true
    remove_column :albums, :visible, :boolean, default: true
    remove_column :albums, :priority, :integer, limit: 2, default: 1
  end
end
