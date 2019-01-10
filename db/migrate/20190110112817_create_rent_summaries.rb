# frozen_string_literal: true

class CreateRentSummaries < ActiveRecord::Migration[5.2]
  def change
    create_table :rent_summaries do |t|
      t.string :year
      t.decimal :rr_count_total
      t.decimal :jan_1999_asset_values_total
      t.decimal :formula_rent_prev_year_average
      t.decimal :rent_cap_prev_year_average
      t.decimal :current_rent_as_at_2407_of_prev_year_average
      t.decimal :formula_rent_this_year_average
      t.decimal :rent_cap_this_year_average
      t.decimal :lower_of_formula_rent_or_cap_average
      t.decimal :uprated_actual_average
      t.decimal :actual_rent_this_year_average
      t.decimal :ratio_of_actual_rent_this_year_to_current_rent_at_2407_of_prev_year
      t.decimal :ar_average_fr_average_difference
      t.decimal :full_year_forecast_average
      t.decimal :year_on_year_percentage_change_average

      t.timestamps
    end
  end
end
