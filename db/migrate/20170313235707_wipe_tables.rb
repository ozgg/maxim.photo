class WipeTables < ActiveRecord::Migration[5.0]
  def up
    drop_table :agents
    drop_table :browsers
    drop_table :users
    drop_table :metric_values
    drop_table :metrics
  end
end
