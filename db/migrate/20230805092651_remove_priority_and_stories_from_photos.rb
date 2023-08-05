class RemovePriorityAndStoriesFromPhotos < ActiveRecord::Migration[5.2]
  def change
    remove_reference :photos, :stories, foreign_key: { on_update: :cascade, on_delete: :nullify }
    remove_column :photos, :priority, :integer, limit: 2, default: 1
    remove_column :photos, :story_id, :integer
  end
end
