
# frozen_string_literal: true

FactoryBot.define do
  factory :cpi_fixed_datum do
    year { Faker::Number.between(1980, 2050) }
    rc_uplift { Faker::Number.between(0, 0.01) }
  end
end
