require 'rails_helper'

RSpec.describe RentCharge, type: :model do

  it { should validate_presence_of(:uprn) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:address_2) }
  it { should validate_presence_of(:rr_count) }
  it { should validate_presence_of(:property_type) }
  it { should validate_presence_of(:base_data_bed_size) }
  it { should validate_presence_of(:bedroom_weight) }
  it { should validate_presence_of(:mra_archetype) }
  it { should validate_presence_of(:jan_1999_asset_values) }
  it { should validate_presence_of(:formula_rent_prev_year) }
  it { should validate_presence_of(:rent_cap_prev_year) }
  it { should validate_presence_of(:current_rent_as_at_2407_of_prev_year) }
  it { should validate_presence_of(:year) }

end
