class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :photos_count, null: false, default: 0
      t.boolean :hidden, null: false, default: false
      t.integer :priority, null: false, default: 0
      t.string :image
      t.string :slug, null: false
      t.string :name_ru, null: false
      t.string :name_en, null: false
      t.string :name_es, null: false
      t.text :description_ru
      t.text :description_en
      t.text :description_es

      t.timestamps null: false
    end
  end
end
