class FixTableNames < ActiveRecord::Migration[5.2]
  def change
    rename_table :cpi_fixed_data, :fixed_data
    rename_table :rent_detail201920s, :rent_charges
  end
end
