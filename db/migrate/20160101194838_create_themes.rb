class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.timestamps null: false
      t.boolean :visible, null: false, default: true
      t.integer :priority, limit: 2, null: false, default: 0
      t.string :name, null: false
      t.string :image
    end
  end
end
