# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RentCharges API', type: :request do
  describe 'POST /rent-charges' do
    let(:rent_charges_gateway) { RentChargesGateway.new }
    let(:fixed_data_gateway) { FixedDataGateway.new }
    let(:update_rent_charges) { UpdateRentCharges.new }

    let(:valid_attributes) { { rc_uplift: '-0.01', year: '2014' } }

    let(:rent_charges) { [
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
        year: 2013,
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
        year: 2010,
        removed: :False,
        formula_rent_this_year: 160,
        rent_cap_this_year: 120,
        uprated_actual: 110
      },
      {
        uprn: '789ghi',
        address: '3 fake street',
        address_2: 'fake village',
        comments: 'comment 3',
        rr_count: 1,
        property_type: :House,
        base_data_bed_size: 4,
        bedroom_weight: 5,
        mra_archetype: 'archetype 3',
        jan_1999_asset_values: 60000,
        year: 2013,
        removed: :False,
        formula_rent_this_year: 125,
        rent_cap_this_year: 140,
        uprated_actual: 190
      }
    ]}

    before do
      rent_charges_gateway.save(rent_charges)
      post '/rent-charges', params: valid_attributes
    end

    it 'creates rent charges for new year' do
      expect(json['year']).to eq('2014')
      expect(json['rc_uplift']).to eq('-0.01')

      expect(rent_charges_gateway.all(2014).count).to eq(2)

      expect(rent_charges_gateway.all(2014).first.uprn).to eq(rent_charges.first[:uprn])
      expect(rent_charges_gateway.all(2014).first.formula_rent_this_year).to eq(168.3)
      expect(rent_charges_gateway.all(2014).first.rent_cap_this_year).to eq(178.2)
      expect(rent_charges_gateway.all(2014).first.uprated_actual).to eq(128.7)
      expect(rent_charges_gateway.all(2014).first.year).to eq(2014)

      expect(rent_charges_gateway.all(2014).second.uprn).to eq(rent_charges.third[:uprn])
      expect(rent_charges_gateway.all(2014).second.formula_rent_this_year).to eq(123.75)
      expect(rent_charges_gateway.all(2014).second.rent_cap_this_year).to eq(138.6)
      expect(rent_charges_gateway.all(2014).second.uprated_actual).to eq(188.1)
      expect(rent_charges_gateway.all(2014).second.year).to eq(2014)
    end

    it 'saves fixed data row' do
      expect(fixed_data_gateway.all.first[:year]).to eq(2014)
      expect(fixed_data_gateway.all.first[:rc_uplift]).to eq(-0.01)
    end

    it 'returns status code 201' do
      expect(response).to have_http_status(201)
    end
  end
end
