class CreateTrackComponent < ActiveRecord::Migration[7.0]
  include Biovision::Migrations::ComponentMigration

  private

  def create_agents
    create_table :agents, comment: 'User agents' do |t|
      t.boolean :banned, default: false, null: false
      t.timestamps
      t.string :name, null: false
    end

    add_index :agents, :name, unique: true
  end

  def create_ip_addresses
    create_table :ip_addresses, comment: 'IP addresses' do |t|
      t.inet :ip, null: false
      t.boolean :banned, default: false, null: false
      t.timestamps
    end

    add_index :ip_addresses, :ip, unique: true
  end
end
