class DropCpiFixedDataAndRentSummaries < ActiveRecord::Migration[5.2]
  def change
    drop_table :cpi_fixed_data
    drop_table :rent_summaries
  end
end
