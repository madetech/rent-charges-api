# frozen_string_literal: true

describe RentDetailsGateway do
  let(:rent_details_gateway) { RentDetailsGateway.new }

  it 'can retrieve no items' do
    data = rent_details_gateway.all
    expect(data).to eq([])
  end

  it 'can retrieve all items' do
    rent_details = [{
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
      formula_rent_this_year: 115,
      rent_cap_this_year: 130,
      lower_of_formula_rent_or_cap: 115,
      uprated_actual: 0.05,
      cap_v_act_plus_2_pounds: 123,
      act_minus_2_pounds: 121,
      actual_rent_this_year: 105,
      converged: 'yes',
      difference_between_ar_and_fr: 100,
      full_year_forecast: 7000,
      year_on_year_percentage_change: 1,
      actual_rent_greater_than_rent_cap: 'no',
      actual_rent_greater_than_formula_rent: 'no',
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
                      formula_rent_this_year: 115,
                      rent_cap_this_year: 130,
                      lower_of_formula_rent_or_cap: 115,
                      uprated_actual: 0.05,
                      cap_v_act_plus_2_pounds: 123,
                      act_minus_2_pounds: 121,
                      actual_rent_this_year: 105,
                      converged: 'yes',
                      difference_between_ar_and_fr: 100,
                      full_year_forecast: 7000,
                      year_on_year_percentage_change: 1,
                      actual_rent_greater_than_rent_cap: 'no',
                      actual_rent_greater_than_formula_rent: 'no',
                      year: '2015-16'
                    }]

    rent_details.each { |data_row| rent_details_gateway.save(data_row) }
    data = rent_details_gateway.all

    expected_data = rent_details

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
      rent_details = [{
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
        formula_rent_this_year: 115,
        rent_cap_this_year: 130,
        lower_of_formula_rent_or_cap: 115,
        uprated_actual: 0.05,
        cap_v_act_plus_2_pounds: 123,
        act_minus_2_pounds: 121,
        actual_rent_this_year: 105,
        converged: 'yes',
        difference_between_ar_and_fr: 100,
        full_year_forecast: 7000,
        year_on_year_percentage_change: 1,
        actual_rent_greater_than_rent_cap: 'no',
        actual_rent_greater_than_formula_rent: 'no',
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
                        formula_rent_this_year: 115,
                        rent_cap_this_year: 130,
                        lower_of_formula_rent_or_cap: 115,
                        uprated_actual: 0.05,
                        cap_v_act_plus_2_pounds: 123,
                        act_minus_2_pounds: 121,
                        actual_rent_this_year: 105,
                        converged: 'yes',
                        difference_between_ar_and_fr: 100,
                        full_year_forecast: 7000,
                        year_on_year_percentage_change: 1,
                        actual_rent_greater_than_rent_cap: 'no',
                        actual_rent_greater_than_formula_rent: 'no',
                        year: '2015-16'
                      }]

      rent_details.each { |data_row| rent_details_gateway.save(data_row) }
      data = rent_details_gateway.find_by_year('2014-15')

      expected_data = rent_details

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
