require 'rails_helper'

RSpec.describe RentDetail201920, type: :model do

  it { should validate_presence_of(:uprn) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:address_2) }
  it { should validate_presence_of(:comments) }
  it { should validate_presence_of(:rr_count) }
  it { should validate_presence_of(:property_type) }
  it { should validate_presence_of(:base_data_bed_size) }
  it { should validate_presence_of(:bedroom_weight) }
  it { should validate_presence_of(:mra_archetype) }
  it { should validate_presence_of(:jan_1999_asset_values) }
  it { should validate_presence_of(:formula_rent_prev_year) }
  it { should validate_presence_of(:rent_cap_prev_year) }
  it { should validate_presence_of(:current_rent_as_at_24_07_of_prev_year) }
  it { should validate_presence_of(:formula_rent_this_year) }
  it { should validate_presence_of(:rent_cap_this_year) }
  it { should validate_presence_of(:lower_of_formula_rent_or_cap) }
  it { should validate_presence_of(:uprated_actual) }
  it { should validate_presence_of(:cap_v_act_plus_2_pounds) }
  it { should validate_presence_of(:act_minus_2_pounds) }
  it { should validate_presence_of(:actual_rent_this_year) }
  it { should validate_presence_of(:converged) }
  it { should validate_presence_of(:difference_between_ar_and_fr) }
  it { should validate_presence_of(:full_year_forecast) }
  it { should validate_presence_of(:year_on_year_percentage_change) }
  it { should validate_presence_of(:actual_rent_greater_than_rent_cap) }
  it { should validate_presence_of(:actual_rent_greater_than_formula_rent) }
  it { should validate_presence_of(:year) }

end
