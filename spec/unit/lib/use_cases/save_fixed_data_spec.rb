# frozen_string_literal: true

require 'rails_helper'

describe SaveFixedData do
  let(:fixed_data_gateway) { spy }
  let(:use_case) do
    described_class.new(fixed_data_gateway: fixed_data_gateway)
  end

  it 'gives error if year value is empty' do
    fixed_data = { year: '' }
    expect(use_case.execute(fixed_data)).to eq(successful: false, errors: [:null_year])
  end

  it 'defaults to -0.01 when rc_uplift nil' do
    fixed_data = {
      year: '2014-15',
      cpi: 0.01,
      real: nil,
      fr_uplift: 0.015,
      rc_factor: 0.001,
      rc_uplift: nil
    }

    use_case.execute(fixed_data)
    
    expect(fixed_data_gateway).to have_received(:save) do |data|
      expect(data[:year]).to eq('2014-15')
      expect(data[:cpi]).to eq(0.01)
      expect(data[:real]).to eq(nil)
      expect(data[:fr_uplift]).to eq(0.015)
      expect(data[:rc_factor]).to eq(0.001)
      expect(data[:rc_uplift]).to eq(-0.01)
    end
  end

  it 'does not default to -0.001 when rc_uplift not nil' do
    fixed_data = {
       year: '2014-15',
       cpi: 0.01,
       real: 0.005,
       fr_uplift: 0.015,
       rc_factor: 0.001,
       rc_uplift: 0.0015
      }
    use_case.execute(fixed_data)
    expect(fixed_data_gateway).to have_received(:save) do |data|
      expect(data[:year]).to eq('2014-15')
      expect(data[:cpi]).to eq(0.01)
      expect(data[:real]).to eq(0.005)
      expect(data[:fr_uplift]).to eq(0.015)
      expect(data[:rc_factor]).to eq(0.001)
      expect(data[:rc_uplift]).to eq(0.0015)
    end
  end
end
