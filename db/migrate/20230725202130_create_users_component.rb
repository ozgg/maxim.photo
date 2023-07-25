class CreateUsersComponent < ActiveRecord::Migration[7.0]
  include Biovision::Migrations::ComponentMigration

  private

  def create_users
    create_table :users, comment: 'Users' do |t|
      t.string :slug, null: false
      t.string :password_digest, null: false
    end

    add_index :users, :slug, unique: true
  end

  def create_tokens
    create_table :tokens, comment: 'Authentication tokens' do |t|
      t.references :user, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :agent, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.references :ip_address, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.timestamps
      t.datetime :last_used, index: true
      t.boolean :active, default: true, null: false
      t.string :token, null: false
    end

    add_index :tokens, :token, unique: true
  end

  def create_login_attempts
    create_table :login_attempts, comment: 'Failed login attempts' do |t|
      t.references :user, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :agent, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.references :ip_address, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.timestamps
      t.string :password, default: '', null: false
    end
  end
end
