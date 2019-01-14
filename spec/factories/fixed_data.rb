# frozen_string_literal: true

FactoryBot.define do
  factory :cpi_fixed_datum do
    year { Faker::Base.regexify(/[0-9]{4}-[0-9]{2}/) }
    cpi { Faker::Number.number(0.01) }
    real { Faker::Number.number(0.01) }
    fr_uplift { Faker::Number.number(0.01) }
    rc_factor { Faker::Number.number(0.01) }
    rc_uplift { Faker::Number.between(0, 0.01) }
  end
end
