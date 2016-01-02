class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.timestamps null: false
      t.references :theme, index: true, foreign_key: true
      t.string :name, null: false
      t.string :slug, null: false
      t.string :image
    end
  end
end
