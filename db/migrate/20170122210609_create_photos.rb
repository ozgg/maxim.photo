class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.timestamps
      t.date :shot_date
      t.boolean :hazard_motion, null: false, default: false
      t.boolean :nudity, null: false, default: false
      t.string :image
      t.string :title
      t.string :keywords
      t.string :lead
      t.text :description
    end
  end
end
