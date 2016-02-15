class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.timestamps null: false
      t.string :title, null: false
      t.string :image
      t.string :lead
      t.text :body, null: false
    end
  end
end
