class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :album, index: true, foreign_key: true
      t.string :image, null: false
      t.string :name_ru
      t.string :name_en
      t.string :name_es
      t.text :description_ru
      t.text :description_en
      t.text :description_es

      t.timestamps null: false
    end
  end
end
