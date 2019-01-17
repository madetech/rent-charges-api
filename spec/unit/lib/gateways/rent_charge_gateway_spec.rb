# frozen_string_literal: true

describe RentChargeGateway do
  let(:rent_charge_gateway) { described_class.new }
  let(:rent_charge) do
    [
      {
        uprn: '123abc',
        address: '1 fake street',
        address_2: 'fake town',
        comments: 'no comment',
        rr_count: 1,
        property_type: 'property',
        base_data_bed_size: 2,
        bedroom_weight: 3,
        mra_archetype: 'archetype',
        jan_1999_asset_values: 100,
        formula_rent_prev_year: 95,
        rent_cap_prev_year: 125,
        current_rent_as_at_2407_of_prev_year: 112,
        year: '2014-15'
      },
      {
        uprn: '456cde',
        address: '2 fake street',
        address_2: 'fake city',
        comments: 'no comment',
        rr_count: 1,
        property_type: 'property',
        base_data_bed_size: 4,
        bedroom_weight: 5,
        mra_archetype: 'archetype',
        jan_1999_asset_values: 100,
        formula_rent_prev_year: 95,
        rent_cap_prev_year: 125,
        current_rent_as_at_2407_of_prev_year: 112,
        year: '2015-16'
      }
    ]
  end

  it 'can retrieve no items' do
    data = rent_charge_gateway.all
    expect(data).to eq([])
  end

  it 'can retrieve all items' do
    rent_charge.each { |data_row| rent_charge_gateway.save(data_row) }
    data = rent_charge_gateway.all

    expected_data = rent_charge

    expect(data.length).to eq(2)
    expect(data[0][:uprn]).to eq(expected_data[0][:uprn])
    expect(data[0][:address]).to eq(expected_data[0][:address])
    expect(data[0][:address_2]).to eq(expected_data[0][:address_2])
    expect(data[0][:year]).to eq(expected_data[0][:year])
    expect(data[1][:uprn]).to eq(expected_data[1][:uprn])
    expect(data[1][:address]).to eq(expected_data[1][:address])
    expect(data[1][:address_2]).to eq(expected_data[1][:address_2])
    expect(data[1][:year]).to eq(expected_data[1][:year])
  end

  context 'specific year' do
    it 'can save and retrieve a record' do
      rent_charge.each { |data_row| rent_charge_gateway.save(data_row) }
      data = rent_charge_gateway.find_by_year('2014-15')

      expected_data = rent_charge

      expect(data[:uprn]).to eq(expected_data[0][:uprn])
      expect(data[:address]).to eq(expected_data[0][:address])
      expect(data[:address_2]).to eq(expected_data[0][:address_2])
      expect(data[:year]).to eq(expected_data[0][:year])
      expect(data[:jan_1999_asset_values])
        .to eq(expected_data[0][:jan_1999_asset_values])
      expect(data[:formula_rent_prev_year])
        .to eq(expected_data[0][:formula_rent_prev_year])
      expect(data[:rent_cap_prev_year])
        .to eq(expected_data[0][:rent_cap_prev_year])
    end
  end
end
