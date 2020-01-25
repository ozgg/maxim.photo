# frozen_string_literal: true

# Create table for instagram image feed
class CreateInstagramImages < ActiveRecord::Migration[5.2]
  def change
    create_table :instagram_images, comment: 'Images from instagram feed' do |t|
      t.timestamps
      t.string :slug, index: true, null: false
      t.string :code, null: false
      t.string :thumbnail_url, null: false
    end
  end
end
