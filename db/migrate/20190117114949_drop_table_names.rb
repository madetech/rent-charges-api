class DropTableNames < ActiveRecord::Migration[5.2]
  def change
    drop_table :removals
    drop_table :rpi_fixed_data
    drop_table :rent_summaries
  end
end
