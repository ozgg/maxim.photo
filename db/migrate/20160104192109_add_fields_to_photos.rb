class AddFieldsToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :preview, :string
    add_reference :photos, :album, index: true, foreign_key: true
  end
end
