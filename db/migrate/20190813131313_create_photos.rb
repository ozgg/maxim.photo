# frozen_string_literal: true

# Create component and tables for photos
class CreatePhotos < ActiveRecord::Migration[5.2]
  def up
    create_component
    create_albums unless Album.table_exists?
    create_photos unless Photo.table_exists?
    create_photo_tags unless PhotoTag.table_exists?
    create_photo_photo_tags unless PhotoPhotoTag.table_exists?
  end

  def down
    drop_table :photo_photo_tags if PhotoPhotoTag.table_exists?
    drop_table :photo_tags if PhotoTag.table_exists?
    drop_table :photos if Photo.table_exists?
    drop_table :albums if Album.table_exists?
  end

  private

  def create_component
    BiovisionComponent.create(slug: Biovision::Components::PhotosComponent::SLUG)
  end

  def create_albums
    create_table :albums, comment: 'Album for photos' do |t|
      t.string :name, index: true, null: false
      t.string :slug, index: true, null: false
      t.timestamps
      t.boolean :visible, default: true, null: false
      t.integer :photos_count, default: 0, null: false
      t.string :image
      t.string :description
      t.string :image_alt_text
      t.string :meta_title
      t.string :meta_description
      t.string :meta_keywords
    end
  end

  def create_photos
    create_table :photos, comment: 'Photo' do |t|
      t.references :album, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.boolean :visible, default: true, null: false
      t.integer :priority, limit: 2, default: 1, null: false
      t.timestamps
      t.string :title
      t.string :image
      t.string :image_alt_text
      t.string :meta_title
      t.string :meta_description
      t.string :meta_keywords
    end
  end

  def create_photo_tags
    create_table :photo_tags, comment: 'Tag for photo' do |t|
      t.string :name, index: true, null: false
      t.string :slug, index: true, null: false
      t.integer :photos_count, default: 0, null: false
    end
  end

  def create_photo_photo_tags
    create_table :photo_photo_tags, comment: 'Link between tag and photo' do |t|
      t.references :photo, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :photo_tag, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
    end
  end
end
