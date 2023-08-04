class CreateFeaturedAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :featured_albums do |t|
      t.references :album, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.integer :priority, limit: 2, null: false, default: 1
    end

    reversible do |direction|
      direction.up do
        Album.frontpage.each do |album|
          FeaturedAlbum.create(album: album)
        end
      end
    end
  end
end
