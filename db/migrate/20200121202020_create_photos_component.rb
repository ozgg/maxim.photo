# frozen_string_literal: true

# Create tables for photos component
class CreatePhotosComponent < ActiveRecord::Migration[5.2]
  def up
    create_component
    create_albums unless Album.table_exists?
    create_photos unless Photo.table_exists?
    create_featured_photos unless FeaturedPhoto.table_exists?
    create_photo_tags unless PhotoTag.table_exists?
    create_photo_photo_tags unless PhotoPhotoTag.table_exists?
  end

  def down
    drop_table :photo_photo_tags if PhotoPhotoTag.table_exists?
    drop_table :photo_tags if PhotoTag.table_exists?
    drop_table :featured_photos if FeaturedPhoto.table_exists?
    drop_table :photos if Photo.table_exists?
    drop_table :albums if Album.table_exists?
  end

  private

  def create_component
    BiovisionComponent.create(slug: Biovision::Components::PhotosComponent.slug)
  end

  def create_albums
    create_table :albums, comment: 'Photo albums' do |t|
      t.uuid :uuid, null: false
      t.timestamps
      t.integer :photos_count, default: 0, null: false
      t.string :name
      t.string :slug, null: false
      t.string :image
      t.string :image_alt_text
      t.string :description
    end

    add_index :albums, :uuid, unique: true
    add_index :albums, :slug, unique: true
  end

  def create_photos
    create_table :photos, comment: 'Photos' do |t|
      t.references :album, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.uuid :uuid, null: false
      t.timestamps
      t.string :image
      t.string :image_alt_text
      t.string :title
      t.text :description
    end

    add_index :photos, :uuid, unique: true
  end

  def create_featured_photos
    create_table :featured_photos, comment: 'Photo for front page' do |t|
      t.references :photo, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.integer :priority, limit: 2, default: 1, null: false
    end
  end

  def create_photo_tags
    create_table :photo_tags, comment: 'Photo tags' do |t|
      t.uuid :uuid
      t.integer :photos_count, default: 0, null: false
      t.string :name, null: false
      t.string :slug, null: false
    end

    add_index :photo_tags, :uuid, unique: true
  end

  def create_photo_photo_tags
    create_table :photo_photo_tags, comment: 'Links between photos and tags' do |t|
      t.references :photo, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :photo_tag, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
    end
  end
end
