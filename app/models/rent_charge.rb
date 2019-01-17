class RentCharge < ApplicationRecord

  validates_presence_of :uprn
  validates_presence_of :address
  validates_presence_of :address_2
  validates_presence_of :rr_count
  validates_presence_of :property_type
  validates_presence_of :base_data_bed_size
  validates_presence_of :bedroom_weight
  validates_presence_of :mra_archetype
  validates_presence_of :jan_1999_asset_values
  validates_presence_of :formula_rent_prev_year
  validates_presence_of :rent_cap_prev_year
  validates_presence_of :current_rent_as_at_2407_of_prev_year
  validates_presence_of :year

end
