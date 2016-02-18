class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :body, null: false
      t.integer :post_count, limit: 2, null: false, default: 0
    end
  end
end
