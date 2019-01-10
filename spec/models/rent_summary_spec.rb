# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RentSummary, type: :model do
  it { should validate_presence_of(:year) }
  it { should validate_presence_of(:rr_count_total) }
  it { should validate_presence_of(:jan_1999_asset_values_total) }
  it { should validate_presence_of(:formula_rent_prev_year_average) }
  it { should validate_presence_of(:rent_cap_prev_year_average) }
  it { should validate_presence_of(:current_rent_as_at_2407_of_prev_year_average) }
  it { should validate_presence_of(:formula_rent_this_year_average) }
  it { should validate_presence_of(:rent_cap_this_year_average) }
  it { should validate_presence_of(:lower_of_formula_rent_or_cap_average) }
  it { should validate_presence_of(:uprated_actual_average) }
  it { should validate_presence_of(:actual_rent_this_year_average) }
  it { should validate_presence_of(:ratio_of_actual_rent_this_year_to_current_rent_at_2407_of_prev_year) }
  it { should validate_presence_of(:ar_average_fr_average_difference) }
  it { should validate_presence_of(:full_year_forecast_average) }
  it { should validate_presence_of(:year_on_year_percentage_change_average) }
end
