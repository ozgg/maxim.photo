class CreateAlbums < ActiveRecord::Migration[5.2]
  def up
    unless Album.table_exists?
      create_table :albums do |t|
        t.timestamps
        t.boolean :visible, default: true, null: false
        t.boolean :highlight, default: false, null: false
        t.integer :photos_count, limit: 2, default: 0, null: false
        t.integer :priority, limit: 2, default: 1, null: false
        t.string :title, null: false
        t.string :slug, null: false
        t.string :image
        t.string :image_alt_text
        t.string :meta_title
        t.string :meta_description
        t.string :meta_keywords
      end

      create_privileges
    end
  end

  def down
    if Album.table_exists?
      drop_table :albums
    end
  end

  private

  def create_privileges
    Privilege.create(slug: 'photo_manager', name: 'Управляющий фотографиями')
  end
end
