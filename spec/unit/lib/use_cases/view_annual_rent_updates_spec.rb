require 'rails_helper'

describe ViewAnnualRentUpdates do
  let!(:fixed_data) { create_list(:fixed_datum, 10) }

  let(:year_1) { fixed_data.first.year }
  let(:year_2) { Faker::Number.between(1, 20) + fixed_data.second.year }

  let(:rent_charges_gateway ) do
    double(all_rent_charges:[
      create(:rent_charge, year: year_1), 
      create(:rent_charge, year: year_2), 
      create(:rent_charge, year: year_1), 
      create(:rent_charge, year: year_2),
      create(:rent_charge, year: year_1)
    ]) 
  end 

  let(:fixed_data_gateway) { spy }
  
  let(:view_annual_rent_updates) do
    described_class.new(rent_charges_gateway: rent_charges_gateway, fixed_data_gateway: fixed_data_gateway)
  end

  let!(:rc_uplift) { allow(fixed_data_gateway).to receive(:rc_uplift).with(year_1) { -0.01 } }
    
  context 'given no historical data' do
    let(:rent_charges_gateway ) { double(all_rent_charges:[]) }
    let!(:rc_uplift) { 0.0 }

    it 'returns no records' do
      response = view_annual_rent_updates.execute
      expect(response).to eq([])
    end 
  end 

  it 'returns an error when the specific year that does not exist in the record' do
    allow(fixed_data_gateway).to receive(:rc_uplift) { -0.01 }
    response = view_annual_rent_updates.specific_year(year: 2014)
    expect(response).to eq({ successful: false, errors: [:no_record_found]})
  end 

  context 'given historical data' do
    it 'returns year, number of accounts affected for each annual rent update' do
      allow(fixed_data_gateway).to receive(:rc_uplift).with(year_2) { -0.02 }
      response = view_annual_rent_updates.execute
      expect(response).to eq([
        {year: year_1, rc_uplift: -0.01, no_of_accounts: 3}, 
        {year: year_2, rc_uplift: -0.02, no_of_accounts: 2}
      ])
    end 

    it 'returns year, number of accounts affected for each annual rent update for specific year' do
      response = view_annual_rent_updates.specific_year(year: year_1)
      expect(response).to eq({year: year_1, rc_uplift: -0.01, no_of_accounts: 3})
    end 
  end 

  context 'given invalid year' do
     it 'returns error if no year' do
      response = view_annual_rent_updates.specific_year(year: nil)
      expect(response).to eq({ successful: false, errors: [:missing_year, :invalid_year, :no_record_found] })
    end

     it 'returns error if invalid year' do
      response = view_annual_rent_updates.specific_year(year: 'nil')
      expect(response).to eq({ successful: false, errors: [:invalid_year, :no_record_found] })
    end
  end
end

