class ModifyRentChargesColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :rent_charges, :formula_rent_this_year, :decimal
    add_column :rent_charges, :rent_cap_this_year, :decimal
    add_column :rent_charges, :uprated_actual, :decimal
    remove_column :rent_charges, :formula_rent_prev_year, :decimal
    remove_column :rent_charges, :rent_cap_prev_year, :decimal
    remove_column :rent_charges, :current_rent_as_at_24_07_of_prev_year, :decimal
  end
end
