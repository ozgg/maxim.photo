class CreatePhotos < ActiveRecord::Migration[5.1]
  def up
    unless Photo.table_exists?
      create_table :photos do |t|
        t.timestamps
        t.references :album, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
        t.integer :priority, limit: 2, default: 1, null: false
        t.integer :height, limit: 2
        t.integer :width, limit: 2
        t.boolean :visible, default: true, null: false
        t.boolean :highlight, default: false, null: false
        t.string :caption, null: false
        t.string :slug, null: false
        t.string :image
        t.string :image_alt_text
        t.string :meta_title
        t.string :meta_keywords
        t.string :meta_description
        t.text :description
        t.json :exif
      end
    end
  end

  def down
    if Photo.table_exists?
      drop_table :photos
    end
  end
end
