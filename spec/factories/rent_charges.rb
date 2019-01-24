FactoryBot.define do
  year = Faker::Number.between(2000, 2050)

  property_type_enumerables = Models::RentCharge.property_types

  factory :rent_charge, :class => Models::RentCharge do
    uprn { Faker::Base.regexify(/[0-9]{3}[a-z]{3}/) }
    address { Faker::Base.regexify(/[0-9]{1,2} [a-z]{5,10}/) }
    address_2 { Faker::Base.regexify(/[A-Z]{1}[a-z]{5,10}/) }
    comments { Faker::Base.regexify(/[a-z ]{15}/) }
    rr_count { Faker::Number.between(1, 3) }
    property_type { property_type_enumerables.map { |key, value| key }.sample }
    base_data_bed_size { Faker::Number.between(1, 3) }
    bedroom_weight { Faker::Number.between(0, 1) }
    mra_archetype { Faker::Base.regexify(/[a-z]{5,10}/) }
    jan_1999_asset_values { Faker::Number.between(20000, 100000) }
    year { year }
    removed { Faker::Boolean }
    formula_rent_this_year { Faker::Number.between(100, 200) }
    rent_cap_this_year { Faker::Number.between(100, 200) }
    uprated_actual { Faker::Number.between(100, 200) }
  end

  factory :rent_charge_different_years, :class => Models::RentCharge do
    uprn { Faker::Base.regexify(/[0-9]{3}[a-z]{3}/) }
    address { Faker::Base.regexify(/[0-9]{1,2} [a-z]{5,10}/) }
    address_2 { Faker::Base.regexify(/[A-Z]{1}[a-z]{5,10}/) }
    comments { Faker::Base.regexify(/[a-z ]{15}/) }
    rr_count { Faker::Number.between(1, 3) }
    property_type { property_type_enumerables.map { |key, value| key }.sample }
    base_data_bed_size { Faker::Number.between(1, 3) }
    bedroom_weight { Faker::Number.between(0, 1) }
    mra_archetype { Faker::Base.regexify(/[a-z]{5,10}/) }
    jan_1999_asset_values { Faker::Number.between(20000, 100000) }
    year { Faker::Number.between(1, 20) + year  }
    removed { Faker::Boolean }
    formula_rent_this_year { Faker::Number.between(100, 200) }
    rent_cap_this_year { Faker::Number.between(100, 200) }
    uprated_actual { Faker::Number.between(100, 200) }
  end

  factory :more_rent_charge_same_year, :class => Models::RentCharge do
    uprn { Faker::Base.regexify(/[0-9]{3}[a-z]{3}/) }
    address { Faker::Base.regexify(/[0-9]{1,2} [a-z]{5,10}/) }
    address_2 { Faker::Base.regexify(/[A-Z]{1}[a-z]{5,10}/) }
    comments { Faker::Base.regexify(/[a-z ]{15}/) }
    rr_count { Faker::Number.between(1, 3) }
    property_type { property_type_enumerables.map { |key, value| key }.sample }
    base_data_bed_size { Faker::Number.between(1, 3) }
    bedroom_weight { Faker::Number.between(0, 1) }
    mra_archetype { Faker::Base.regexify(/[a-z]{5,10}/) }
    jan_1999_asset_values { Faker::Number.between(20000, 100000) }
    year { year }
    removed { Faker::Boolean }
    formula_rent_this_year { Faker::Number.between(100, 200) }
    rent_cap_this_year { Faker::Number.between(100, 200) }
    uprated_actual { Faker::Number.between(100, 200) }
  end
end
