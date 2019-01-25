# frozen_string_literal: true

describe RentChargesGateway do
  let(:rent_charges_gateway) { RentChargesGateway.new }
  let(:rent_charges_for_given_year) { [
    { 
      uprn: '123abc',
      address: '1 fake street',
      address_2: 'fake town',
      comments: 'comment 1',
      rr_count: 1,
      property_type: :Flat,
      base_data_bed_size: 2,
      bedroom_weight: 1,
      mra_archetype: 'archetype 1',
      jan_1999_asset_values: 45000,
      year: 2014,
      removed: :false,
      formula_rent_this_year: 170,
      rent_cap_this_year: 180,
      uprated_actual: 130
    },
    { 
      uprn: '456def',
      address: '2 fake street',
      address_2: 'fake city',
      comments: 'comment 2',
      rr_count: 1,
      property_type: :House,
      base_data_bed_size: 3,
      bedroom_weight: 2,
      mra_archetype: 'archetype 2',
      jan_1999_asset_values: 50000,
      year: 2014,
      removed: :false,
      formula_rent_this_year: 160,
      rent_cap_this_year: 120,
      uprated_actual: 110
    }
  ]}

  it 'creates new rows for the new year' do
    rent_charges_gateway.save(rent_charges_for_given_year)
    rent_charges = rent_charges_gateway.all(2014)

    expect(rent_charges[0].uprn).to eq('123abc')
    expect(rent_charges[0].address).to eq('1 fake street')
    expect(rent_charges[0].address_2).to eq('fake town')
    expect(rent_charges[0].comments).to eq('comment 1')
    expect(rent_charges[0].rr_count).to eq(1)
    expect(rent_charges[0].property_type).to eq('Flat')
    expect(rent_charges[0].base_data_bed_size).to eq(2)
    expect(rent_charges[0].bedroom_weight).to eq(1)
    expect(rent_charges[0].mra_archetype).to eq('archetype 1')
    expect(rent_charges[0].jan_1999_asset_values).to eq(45000)
    expect(rent_charges[0].year).to eq(2014)
    expect(rent_charges[0].formula_rent_this_year).to eq(170)
    expect(rent_charges[0].rent_cap_this_year).to eq(180)
    expect(rent_charges[0].uprated_actual).to eq(130)

    expect(rent_charges[1].uprn).to eq('456def')
    expect(rent_charges[1].address).to eq('2 fake street')
    expect(rent_charges[1].address_2).to eq('fake city')
    expect(rent_charges[1].comments).to eq('comment 2')
    expect(rent_charges[1].rr_count).to eq(1)
    expect(rent_charges[1].property_type).to eq('House')
    expect(rent_charges[1].base_data_bed_size).to eq(3)
    expect(rent_charges[1].bedroom_weight).to eq(2)
    expect(rent_charges[1].mra_archetype).to eq('archetype 2')
    expect(rent_charges[1].jan_1999_asset_values).to eq(50000)
    expect(rent_charges[1].year).to eq(2014)
    expect(rent_charges[1].formula_rent_this_year).to eq(160)
    expect(rent_charges[1].rent_cap_this_year).to eq(120)
    expect(rent_charges[1].uprated_actual).to eq(110)
  end

  let(:property_type_enumerables) { Models::RentCharge.property_types }

  def property_types
    property_type_enumerables.map { |key, value| key }
  end

  let(:year) { Faker::Number.between(2000, 2050) }
  let(:rent_charges_for_different_year) { [
    { 
      uprn: Faker::Base.regexify(/[0-9]{3}[a-z]{3}/),
      address: Faker::Base.regexify(/[0-9]{1,2} [a-z]{5,10}/),
      address_2: Faker::Base.regexify(/[A-Z]{1}[a-z]{5,10}/),
      comments: Faker::Base.regexify(/[a-z ]{15}/),
      rr_count: Faker::Number.between(1, 3),
      property_type: property_types.sample,
      base_data_bed_size: Faker::Number.between(1, 3),
      bedroom_weight: Faker::Number.between(0, 1),
      mra_archetype: Faker::Base.regexify(/[a-z]{5,10}/),
      jan_1999_asset_values: Faker::Number.between(20000, 100000),
      year: year,
      removed: :false,
      formula_rent_this_year: Faker::Number.between(100, 200),
      rent_cap_this_year: Faker::Number.between(100, 200),
      uprated_actual: Faker::Number.between(100, 200)
    }
  ]}

  it 'creates new rows for different year' do
    rent_charges_gateway.save(rent_charges_for_different_year)
    rent_charges = rent_charges_gateway.all(year)

    expect(rent_charges[0].uprn).to eq(rent_charges_for_different_year[0][:uprn])
    expect(rent_charges[0].address).to eq(rent_charges_for_different_year[0][:address])
    expect(rent_charges[0].address_2).to eq(rent_charges_for_different_year[0][:address_2])
    expect(rent_charges[0].comments).to eq(rent_charges_for_different_year[0][:comments])
    expect(rent_charges[0].rr_count).to eq(rent_charges_for_different_year[0][:rr_count])
    expect(rent_charges[0].property_type).to eq(rent_charges_for_different_year[0][:property_type])
    expect(rent_charges[0].base_data_bed_size).to eq(rent_charges_for_different_year[0][:base_data_bed_size])
    expect(rent_charges[0].bedroom_weight).to eq(rent_charges_for_different_year[0][:bedroom_weight])
    expect(rent_charges[0].mra_archetype).to eq(rent_charges_for_different_year[0][:mra_archetype])
    expect(rent_charges[0].jan_1999_asset_values).to eq(rent_charges_for_different_year[0][:jan_1999_asset_values])
    expect(rent_charges[0].year).to eq(rent_charges_for_different_year[0][:year])
    expect(rent_charges[0].formula_rent_this_year).to eq(rent_charges_for_different_year[0][:formula_rent_this_year])
    expect(rent_charges[0].rent_cap_this_year).to eq(rent_charges_for_different_year[0][:rent_cap_this_year])
    expect(rent_charges[0].uprated_actual).to eq(rent_charges_for_different_year[0][:uprated_actual])
  end
end
