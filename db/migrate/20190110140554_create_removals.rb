class CreateRemovals < ActiveRecord::Migration[5.2]
  def change
    create_table :removals do |t|
      t.string :uprn
      t.string :address
      t.string :address_2
      t.string :comments
      t.decimal :rr_count
      t.string :property_type
      t.decimal :base_data_bed_size
      t.decimal :bedroom_weight
      t.string :mra_archetype
      t.decimal :jan_1999_asset_values
      t.decimal :formula_rent_prev_year
      t.decimal :rent_cap_prev_year
      t.decimal :current_rent_as_at_22_10_of_prev_year
      t.decimal :formula_rent_this_year
      t.decimal :rent_cap_this_year
      t.decimal :lower_of_formula_rent_or_cap
      t.decimal :uprated_actual
      t.decimal :cap_v_act_plus_2_pounds
      t.decimal :act_minus_2_pounds
      t.decimal :actual_rent_this_year
      t.string :converged
      t.decimal :difference_between_ar_and_fr
      t.decimal :full_year_forecast
      t.decimal :year_on_year_percentage_change
      t.string :actual_rent_greater_than_rent_cap
      t.string :actual_rent_greater_than_formula_rent
      t.string :year

      t.timestamps
    end
  end
end
