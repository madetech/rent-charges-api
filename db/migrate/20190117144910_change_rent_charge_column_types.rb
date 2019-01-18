class ChangeRentChargeColumnTypes < ActiveRecord::Migration[5.2]
  def change
    change_column :rent_charges, :base_data_bed_size, :integer
    change_column :rent_charges, :year, :integer
    change_column :rent_charges, :property_type, :integer
  end
end
