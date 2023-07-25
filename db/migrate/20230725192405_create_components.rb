class CreateComponents < ActiveRecord::Migration[7.0]
  def change
    create_table :components, comment: 'Biovision CMS components' do |t|
      t.integer :priority, limit: 2, default: 1, null: false
      t.string :slug, null: false
      t.timestamps
      t.jsonb :settings, default: {}, null: false
    end

    add_index :components, :slug, unique: true
  end
end
