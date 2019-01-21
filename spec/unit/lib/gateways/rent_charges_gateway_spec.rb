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
      removed: :False,
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
      removed: :False,
      formula_rent_this_year: 160,
      rent_cap_this_year: 120,
      uprated_actual: 110
    }
  ]}

  it 'creates new rows for the new year' do
    rent_charges_gateway.save(rent_charges_for_given_year)
    rent_charges = rent_charges_gateway.all(2014)
    expect(rent_charges[0][:uprn]).to eq('123abc')
    expect(rent_charges[0][:address]).to eq('1 fake street')
    expect(rent_charges[0][:address_2]).to eq('fake town')
    expect(rent_charges[0][:comments]).to eq('comment 1')
    expect(rent_charges[0][:rr_count]).to eq(1)
    expect(rent_charges[0][:property_type]).to eq('Flat')
    expect(rent_charges[0][:base_data_bed_size]).to eq(2)
    expect(rent_charges[0][:bedroom_weight]).to eq(1)
    expect(rent_charges[0][:mra_archetype]).to eq('archetype 1')
    expect(rent_charges[0][:jan_1999_asset_values]).to eq(45000)
    expect(rent_charges[0][:year]).to eq(2014)
    expect(rent_charges[0][:formula_rent_this_year]).to eq(170)
    expect(rent_charges[0][:rent_cap_this_year]).to eq(180)
    expect(rent_charges[0][:uprated_actual]).to eq(130)

    expect(rent_charges[1][:uprn]).to eq('456def')
    expect(rent_charges[1][:address]).to eq('2 fake street')
    expect(rent_charges[1][:address_2]).to eq('fake city')
    expect(rent_charges[1][:comments]).to eq('comment 2')
    expect(rent_charges[1][:rr_count]).to eq(1)
    expect(rent_charges[1][:property_type]).to eq('House')
    expect(rent_charges[1][:base_data_bed_size]).to eq(3)
    expect(rent_charges[1][:bedroom_weight]).to eq(2)
    expect(rent_charges[1][:mra_archetype]).to eq('archetype 2')
    expect(rent_charges[1][:jan_1999_asset_values]).to eq(50000)
    expect(rent_charges[1][:year]).to eq(2014)
    expect(rent_charges[1][:formula_rent_this_year]).to eq(160)
    expect(rent_charges[1][:rent_cap_this_year]).to eq(120)
    expect(rent_charges[1][:uprated_actual]).to eq(110)
  end
end
