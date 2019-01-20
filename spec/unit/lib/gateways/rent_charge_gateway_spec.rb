describe RentDetailGateway do
  let(:rent_detail_gateway) { RentDetailGateway.new }
  let(:rent_details_for_given_year) { [
    { 
      uprn: '123abc',
      address: '1 fake street',
      address_2: 'fake town',
      comments: 'comment 1',
      rr_count: 1,
      property_type: 'property type 1',
      base_data_bed_size: 2,
      bedroom_weight: 1,
      mra_archetype: 'archetype 1',
      jan_1999_asset_values: 45000,
      year: 2014,
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
      property_type: 'property type 2',
      base_data_bed_size: 3,
      bedroom_weight: 2,
      mra_archetype: 'archetype 2',
      jan_1999_asset_values: 50000,
      year: 2014,
      formula_rent_this_year: 170,
      rent_cap_this_year: 180,
      uprated_actual: 130
    }
  ]}

  xit 'creates new rows for the new year' do
    rent_detail_gateway.save(rent_details_for_given_year)
    rent_details = rent_detail_gateway.all(2014)
    expect(rent_details[0][:uprn]).to eq('123abc')
  end
end
