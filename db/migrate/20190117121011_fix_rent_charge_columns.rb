class FixRentChargeColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :rent_charges, :formula_rent_this_year
    remove_column :rent_charges, :rent_cap_this_year
    remove_column :rent_charges, :lower_of_formula_rent_or_cap
    remove_column :rent_charges, :uprated_actual
    remove_column :rent_charges, :cap_v_act_plus_2_pounds
    remove_column :rent_charges, :act_minus_2_pounds
    remove_column :rent_charges, :actual_rent_this_year
    remove_column :rent_charges, :converged
    remove_column :rent_charges, :difference_between_ar_and_fr
    remove_column :rent_charges, :full_year_forecast
    remove_column :rent_charges, :year_on_year_percentage_change
    remove_column :rent_charges, :actual_rent_greater_than_rent_cap
    remove_column :rent_charges, :actual_rent_greater_than_formula_rent
  end
end
