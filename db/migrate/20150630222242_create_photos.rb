class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.boolean :visible, null: false, default: true
      t.string :name, null: false
      t.string :image, null: false
      t.string :description

      t.timestamps null: false
    end
  end
end
