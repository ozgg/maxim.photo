class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.timestamps
      t.string :slug
      t.string :password_digest
    end

    add_index :users, :slug, unique: true
  end
end
