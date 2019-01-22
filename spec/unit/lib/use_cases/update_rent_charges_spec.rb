describe UpdateRentCharges do
  let(:year) { Faker::Number.between(2000, 2050) }

  let(:rent_charges_for_given_year) { [
    Domain::RentCharge.new(
      uprn: Faker::Base.regexify(/[0-9]{3}[a-z]{3}/),
      address: Faker::Base.regexify(/[0-9]{1,2} [a-z]{5,10}/),
      address_2: Faker::Base.regexify(/[A-Z]{1}[a-z]{5,10}/),
      comments: Faker::Base.regexify(/[a-z ]{15}/),
      rr_count: Faker::Number.between(1, 3),
      property_type: Faker::Number.between(0, 4),
      base_data_bed_size: Faker::Number.between(1, 3),
      bedroom_weight: Faker::Number.between(0.1, 1),
      mra_archetype: Faker::Base.regexify(/[a-z]{5,10}/),
      jan_1999_asset_values: Faker::Number.between(20000, 100000),
      year: year,
      removed: :false,
      formula_rent_this_year: Faker::Number.between(100, 200),
      rent_cap_this_year: Faker::Number.between(100, 200),
      uprated_actual: Faker::Number.between(100, 200)
    ),
    Domain::RentCharge.new(
      uprn: Faker::Base.regexify(/[0-9]{3}[a-z]{3}/),
      address: Faker::Base.regexify(/[0-9]{1,2} [a-z]{5,10}/),
      address_2: Faker::Base.regexify(/[A-Z]{1}[a-z]{5,10}/),
      comments: Faker::Base.regexify(/[a-z ]{15}/),
      rr_count: Faker::Number.between(1, 3),
      property_type: Faker::Number.between(0, 4),
      base_data_bed_size: Faker::Number.between(1, 3),
      bedroom_weight: Faker::Number.between(0.1, 1),
      mra_archetype: Faker::Base.regexify(/[a-z]{5,10}/),
      jan_1999_asset_values: Faker::Number.between(20000, 100000),
      year: year,
      removed: :false,
      formula_rent_this_year: Faker::Number.between(100, 200),
      rent_cap_this_year: Faker::Number.between(100, 200),
      uprated_actual: Faker::Number.between(100, 200)
    )
  ] }

  let(:fixed_data_gateway) { double(save: nil) }
  let(:rent_charges_gateway) { double(save: nil, all: rent_charges_for_given_year) }

  let(:update_rent_charges) { UpdateRentCharges.new(
    fixed_data_gateway: fixed_data_gateway,
    rent_charges_gateway: rent_charges_gateway
  )}

  it 'saves rc_uplift' do
    update_rent_charges.execute({ year: rent_charges_for_given_year[0].year + 1, rc_uplift: -0.01 })
    expect(fixed_data_gateway).to have_received(:save) do |fixed_data|
      expect(fixed_data[:year]).to eq(rent_charges_for_given_year[0].year + 1)
      expect(fixed_data[:rc_uplift]).to eq(-0.01)
    end
  end

  it 'updates rent charges for a given year' do
    update_rent_charges.execute({ year: rent_charges_for_given_year[0].year + 1, rc_uplift: -0.01 })
    expect(rent_charges_gateway).to have_received(:save) do |rent_charges|
      expect(rent_charges[0][:uprn]).to eq(rent_charges_for_given_year[0].uprn)
      expect(rent_charges[0][:address]).to eq(rent_charges_for_given_year[0].address)
      expect(rent_charges[0][:address_2]).to eq(rent_charges_for_given_year[0].address_2)
      expect(rent_charges[0][:comments]).to eq(rent_charges_for_given_year[0].comments)
      expect(rent_charges[0][:rr_count]).to eq(rent_charges_for_given_year[0].rr_count)
      expect(rent_charges[0][:property_type]).to eq(rent_charges_for_given_year[0].property_type)
      expect(rent_charges[0][:base_data_bed_size]).to eq(rent_charges_for_given_year[0].base_data_bed_size)
      expect(rent_charges[0][:bedroom_weight]).to eq(rent_charges_for_given_year[0].bedroom_weight)
      expect(rent_charges[0][:mra_archetype]).to eq(rent_charges_for_given_year[0].mra_archetype)
      expect(rent_charges[0][:jan_1999_asset_values]).to eq(rent_charges_for_given_year[0].jan_1999_asset_values)
      expect(rent_charges[0][:year]).to eq(rent_charges_for_given_year[0].year + 1)
      expect(rent_charges[0][:formula_rent_this_year]).to eq((rent_charges_for_given_year[0].formula_rent_this_year * 0.99).round(2))
      expect(rent_charges[0][:rent_cap_this_year]).to eq((rent_charges_for_given_year[0].rent_cap_this_year. * 0.99).round(2))
      expect(rent_charges[0][:uprated_actual]).to eq((rent_charges_for_given_year[0].uprated_actual * 0.99).round(2))

      expect(rent_charges[1][:uprn]).to eq(rent_charges_for_given_year[1].uprn)
      expect(rent_charges[1][:address]).to eq(rent_charges_for_given_year[1].address)
      expect(rent_charges[1][:address_2]).to eq(rent_charges_for_given_year[1].address_2)
      expect(rent_charges[1][:comments]).to eq(rent_charges_for_given_year[1].comments)
      expect(rent_charges[1][:rr_count]).to eq(rent_charges_for_given_year[1].rr_count)
      expect(rent_charges[1][:property_type]).to eq(rent_charges_for_given_year[1].property_type)
      expect(rent_charges[1][:base_data_bed_size]).to eq(rent_charges_for_given_year[1].base_data_bed_size)
      expect(rent_charges[1][:bedroom_weight]).to eq(rent_charges_for_given_year[1].bedroom_weight)
      expect(rent_charges[1][:mra_archetype]).to eq(rent_charges_for_given_year[1].mra_archetype)
      expect(rent_charges[1][:jan_1999_asset_values]).to eq(rent_charges_for_given_year[1].jan_1999_asset_values)
      expect(rent_charges[1][:year]).to eq(rent_charges_for_given_year[0].year + 1)
      expect(rent_charges[1][:formula_rent_this_year]).to eq((rent_charges_for_given_year[1].formula_rent_this_year * 0.99).round(2))
      expect(rent_charges[1][:rent_cap_this_year]).to eq((rent_charges_for_given_year[1].rent_cap_this_year * 0.99).round(2))
      expect(rent_charges[1][:uprated_actual]).to eq((rent_charges_for_given_year[1].uprated_actual * 0.99).round(2))
    end
  end

  it 'returns error when missing year' do
    response = update_rent_charges.execute({ year: nil, rc_uplift: -0.01 })
    expect(response).to eq(
      successful: false,
      errors: [:missing_year, :invalid_year]
    )
  end

  it 'returns error when missing rc uplift' do
    response = update_rent_charges.execute({ year: 2015, rc_uplift: nil })
    expect(response).to eq(
      successful: false,
      errors: [:missing_rc_uplift, :invalid_rc_uplift]
    )
  end

  it 'returns error when invalid year and rc uplift' do
    response = update_rent_charges.execute({ year: 201, rc_uplift: 'abc' })
    expect(response).to eq(
      successful: false,
      errors: [:invalid_year, :invalid_rc_uplift]
    )
  end
end
