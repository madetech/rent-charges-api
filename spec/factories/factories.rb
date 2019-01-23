# frozen_string_literal :true
FactoryBot.define do
  factory :fixed_datum, :class => Models::FixedDatum do
    year  Faker::Number.between(2000, 2010)
    rc_uplift Faker::Number.between(1, 2)
  end
  
  factory :rent_charge, :class => Models::RentCharge do
    uprn '123abc'
    address '1 fake street'
    address_2 'fake town'
    comments 'comment 1'
    rr_count 1
    property_type :Flat
    base_data_bed_size 2
    bedroom_weight 1
    mra_archetype 'archetype 1'
    jan_1999_asset_values 45000
    year 2018
    removed :False
    formula_rent_this_year 120
    rent_cap_this_year 180
    uprated_actual 140
  end
end