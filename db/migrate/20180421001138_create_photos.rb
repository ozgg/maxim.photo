class CreatePhotos < ActiveRecord::Migration[5.2]
  def up
    unless Photo.table_exists?
      create_table :photos do |t|
        t.timestamps
        t.references :album, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
        t.boolean :visible, default: true, null: false
        t.integer :priority, limit: 2, default: 1, null: false
        t.string :title
        t.string :image_alt_text
      end
    end
  end

  def down
    if Photo.table_exists?
      drop_table :photos
    end
  end
end
