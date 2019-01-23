require 'rails_helper'

describe ViewAnnualRentUpdates do
  let(:rent_charge_gateway ) do
    double(all:[
      { uprn: 1, year: 2018}, 
      { uprn: 1, year: 2011}, 
      { uprn: 2, year: 2018}, 
      { uprn: 3, year: 2011},
      { uprn: 3, year: 2018}
    ]) 
  end 
  let(:fixed_data_gateway) { spy }
  let(:use_case) do
    described_class.new(rent_charge_gateway: rent_charge_gateway, fixed_data_gateway: fixed_data_gateway)
  end

  context 'given no historical data' do
    let(:rent_charge_gateway ) { double(all:[]) }

    it 'returns no records' do
      allow(fixed_data_gateway).to receive(:rc_uplift) { 0.0 }
      response = use_case.execute
      expect(response).to eq([])
    end 
  end 

  context 'given historical data' do
    it 'returns year, number of accounts affected for each annual rent update' do
      allow(fixed_data_gateway).to receive(:rc_uplift).with(2018) { -0.01 }
      allow(fixed_data_gateway).to receive(:rc_uplift).with(2011) { -0.02 }
      response = use_case.execute
      expect(response).to eq([
        {year: 2018, rc_uplift: -0.01, no_of_accounts: 3}, 
        {year: 2011, rc_uplift: -0.02, no_of_accounts: 2}
      ])
    end 

    it 'returns year, number of accounts affected for each annual rent update for specific year' do
      allow(fixed_data_gateway).to receive(:rc_uplift).with(2018) { -0.01 }
      response = use_case.percent_changes_for_specific_year(2018)
      expect(response).to eq({year: 2018, rc_uplift: -0.01, no_of_accounts: 3})
    end 
  end 

  it 'returns an error when the specific year that doesnt exists in the record' do
    allow(fixed_data_gateway).to receive(:rc_uplift) { -0.01 }
    response = use_case.percent_changes_for_specific_year(2014)
    expect(response).to eq({error: :no_record_found})
  end 
end

