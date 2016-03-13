class CreateIllustrations < ActiveRecord::Migration
  def change
    create_table :illustrations do |t|
      t.references :post, index: true, foreign_key: true, null: false
      t.integer :priority, limit: 2, null: false, default: 1
      t.string :image
      t.string :title
      t.text :description
    end
  end
end
