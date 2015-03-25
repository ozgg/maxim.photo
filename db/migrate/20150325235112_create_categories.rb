class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :visibility, null: false
      t.integer :photo_count, null: false, default: 0
      t.integer :priority, null: false, default: 0
      t.string :image
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
