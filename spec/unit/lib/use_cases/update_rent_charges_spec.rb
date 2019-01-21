describe UpdateRentDetails do
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
      current_rent_as_at_2407_of_prev_year: 120,
      year: 2014,
      formula_rent_this_year: 140,
      rent_cap_this_year: 150,
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
      current_rent_as_at_2407_of_prev_year: 120,
      year: 2014,
      formula_rent_this_year: 105,
      rent_cap_this_year: 162,
      uprated_actual: 147
    }
  ]}

  let(:fixed_data_gateway) { double(save: nil) }
  let(:rent_detail_gateway) { double(save: nil, all: rent_details_for_given_year) }

  let(:update_rent_details) { UpdateRentDetails.new(
    fixed_data_gateway: fixed_data_gateway,
    rent_detail_gateway: rent_detail_gateway
  )}

  it 'saves rc_uplift' do
    update_rent_details.execute({ year: 2015, rc_uplift: -0.01 })
    expect(fixed_data_gateway).to have_received(:save) do |data|
      expect(data[:year]).to eq(2015)
      expect(data[:rc_uplift]).to eq(-0.01)
    end
  end

  it 'updates rent details for a given year' do
    update_rent_details.execute({ year: 2015, rc_uplift: -0.01 })
    expect(rent_detail_gateway).to have_received(:save) do |rent_details|
      expect(rent_details[0][:uprn]).to eq('123abc')
      expect(rent_details[0][:address]).to eq('1 fake street')
      expect(rent_details[0][:address_2]).to eq('fake town')
      expect(rent_details[0][:comments]).to eq('comment 1')
      expect(rent_details[0][:rr_count]).to eq(1)
      expect(rent_details[0][:property_type]).to eq('property type 1')
      expect(rent_details[0][:base_data_bed_size]).to eq(2)
      expect(rent_details[0][:bedroom_weight]).to eq(1)
      expect(rent_details[0][:mra_archetype]).to eq('archetype 1')
      expect(rent_details[0][:jan_1999_asset_values]).to eq(45000)
      expect(rent_details[0][:year]).to eq(2015)
      expect(rent_details[0][:formula_rent_this_year]).to eq(138.6)
      expect(rent_details[0][:rent_cap_this_year]).to eq(148.5)
      expect(rent_details[0][:uprated_actual]).to eq(128.7)


      expect(rent_details[1][:uprn]).to eq('456def')
      expect(rent_details[1][:address]).to eq('2 fake street')
      expect(rent_details[1][:address_2]).to eq('fake city')
      expect(rent_details[1][:comments]).to eq('comment 2')
      expect(rent_details[1][:rr_count]).to eq(1)
      expect(rent_details[1][:property_type]).to eq('property type 2')
      expect(rent_details[1][:base_data_bed_size]).to eq(3)
      expect(rent_details[1][:bedroom_weight]).to eq(2)
      expect(rent_details[1][:mra_archetype]).to eq('archetype 2')
      expect(rent_details[1][:jan_1999_asset_values]).to eq(50000)
      expect(rent_details[1][:year]).to eq(2015)
      expect(rent_details[1][:formula_rent_this_year]).to eq(103.95)
      expect(rent_details[1][:rent_cap_this_year]).to eq(160.38)
      expect(rent_details[1][:uprated_actual]).to eq(145.53)
    end
  end
end
