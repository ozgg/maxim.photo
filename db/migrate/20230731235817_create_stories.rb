class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories, comment: 'Photo stories' do |t|
      t.date :date, null: false, comment: 'Date of the story'
      t.string :slug, null: false, comment: 'Slug for URL'
      t.string :name, null: false, comment: 'Name of the story'
      t.text :description, default: '', null: false, comment: 'Long description'
      t.string :image, comment: 'Cover image'
      t.string :image_alt_text, comment: 'Alternative text for cover image'
    end

    add_reference :photos, :stories, foreign_key: { on_update: :cascade, on_delete: :nullify }
  end
end
