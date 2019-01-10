class Removal < ApplicationRecord

  validates_presence_of :uprn
  validates_presence_of :address
  validates_presence_of :address_2
  validates_presence_of :comments
  validates_presence_of :rr_count
  validates_presence_of :property_type
  validates_presence_of :base_data_bed_size
  validates_presence_of :bedroom_weight
  validates_presence_of :mra_archetype
  validates_presence_of :jan_1999_asset_values
  validates_presence_of :formula_rent_prev_year
  validates_presence_of :rent_cap_prev_year
  validates_presence_of :current_rent_as_at_2210_of_prev_year
  validates_presence_of :formula_rent_this_year
  validates_presence_of :rent_cap_this_year
  validates_presence_of :lower_of_formula_rent_or_cap
  validates_presence_of :uprated_actual
  validates_presence_of :cap_v_act_plus_2_pounds
  validates_presence_of :act_minus_2_pounds
  validates_presence_of :actual_rent_this_year
  validates_presence_of :converged
  validates_presence_of :difference_between_ar_and_fr
  validates_presence_of :full_year_forecast
  validates_presence_of :year_on_year_percentage_change
  validates_presence_of :actual_rent_greater_than_rent_cap
  validates_presence_of :actual_rent_greater_than_formula_rent
  validates_presence_of :year

end
