# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RentCharges API', type: :request do
  describe 'POST /rent-charges' do
    let(:rent_charges_gateway) { RentChargesGateway.new }
    let(:fixed_data_gateway) { FixedDataGateway.new }
    let(:update_rent_charges) { UpdateRentCharges.new }

    let(:year) { Faker::Number.between(2000, 2050) }
    let(:valid_attributes) { { rc_uplift: '-0.01', year: year + 1} }

    let(:rent_charges) { [
      { 
        uprn: Faker::Base.regexify(/[0-9]{3}[a-z]{3}/),
        address: Faker::Base.regexify(/[0-9]{1,2} [a-z]{5,10}/),
        address_2: Faker::Base.regexify(/[A-Z]{1}[a-z]{5,10}/),
        comments: Faker::Base.regexify(/[a-z ]{15}/),
        rr_count: Faker::Number.between(1, 3),
        property_type: 'Flat',
        base_data_bed_size: Faker::Number.between(1, 3),
        bedroom_weight: Faker::Number.between(0, 1),
        mra_archetype: Faker::Base.regexify(/[a-z]{5,10}/),
        jan_1999_asset_values: Faker::Number.between(20000, 100000),
        year: year,
        removed: :false,
        formula_rent_this_year: Faker::Number.between(100, 200),
        rent_cap_this_year: Faker::Number.between(100, 200),
        uprated_actual: Faker::Number.between(100, 200)
      },
      { 
        uprn: Faker::Base.regexify(/[0-9]{3}[a-z]{3}/),
        address: Faker::Base.regexify(/[0-9]{1,2} [a-z]{5,10}/),
        address_2: Faker::Base.regexify(/[A-Z]{1}[a-z]{5,10}/),
        comments: Faker::Base.regexify(/[a-z ]{15}/),
        rr_count: Faker::Number.between(1, 3),
        property_type: 'Flat',
        base_data_bed_size: Faker::Number.between(1, 3),
        bedroom_weight: Faker::Number.between(0, 1),
        mra_archetype: Faker::Base.regexify(/[a-z]{5,10}/),
        jan_1999_asset_values: Faker::Number.between(20000, 100000),
        year: year - 23,
        removed: :false,
        formula_rent_this_year: Faker::Number.between(100, 200),
        rent_cap_this_year: Faker::Number.between(100, 200),
        uprated_actual: Faker::Number.between(100, 200)
      },
      { 
        uprn: Faker::Base.regexify(/[0-9]{3}[a-z]{3}/),
        address: Faker::Base.regexify(/[0-9]{1,2} [a-z]{5,10}/),
        address_2: Faker::Base.regexify(/[A-Z]{1}[a-z]{5,10}/),
        comments: Faker::Base.regexify(/[a-z ]{15}/),
        rr_count: Faker::Number.between(1, 3),
        property_type: 'Flat',
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
    
    context 'valid attributes' do

      before do
        rent_charges_gateway.save(rent_charges)
        post '/rent-charges', params: valid_attributes
      end

      it 'creates rent charges for new year' do
        expect(json_response['year']).to eq((rent_charges.first[:year] + 1).to_s )
        expect(json_response['rc_uplift']).to eq('-0.01')

        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).count).to eq(2)

        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).first.uprn).to eq(rent_charges.first[:uprn])
        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).first.address).to eq(rent_charges.first[:address])
        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).first.address_2).to eq(rent_charges.first[:address_2])
        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).first.comments).to eq(rent_charges.first[:comments])
        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).first.rr_count).to eq(rent_charges.first[:rr_count])
        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).first.property_type).to eq(rent_charges.first[:property_type])
        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).first.base_data_bed_size).to eq(rent_charges.first[:base_data_bed_size])
        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).first.bedroom_weight).to eq(rent_charges.first[:bedroom_weight])
        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).first.mra_archetype).to eq(rent_charges.first[:mra_archetype])
        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).first.jan_1999_asset_values).to eq(rent_charges.first[:jan_1999_asset_values])
        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).first.year).to eq(rent_charges.first[:year] + 1)
        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).first.formula_rent_this_year).to eq((rent_charges.first[:formula_rent_this_year] * 0.99).round(2))
        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).first.rent_cap_this_year).to eq((rent_charges.first[:rent_cap_this_year] * 0.99).round(2))
        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).first.uprated_actual).to eq((rent_charges.first[:uprated_actual] * 0.99).round(2))

        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).second.uprn).to eq(rent_charges.third[:uprn])
        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).second.address).to eq(rent_charges.third[:address])
        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).second.address_2).to eq(rent_charges.third[:address_2])
        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).second.comments).to eq(rent_charges.third[:comments])
        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).second.rr_count).to eq(rent_charges.third[:rr_count])
        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).second.property_type).to eq(rent_charges.third[:property_type])
        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).second.base_data_bed_size).to eq(rent_charges.third[:base_data_bed_size])
        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).second.bedroom_weight).to eq(rent_charges.third[:bedroom_weight])
        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).second.mra_archetype).to eq(rent_charges.third[:mra_archetype])
        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).second.jan_1999_asset_values).to eq(rent_charges.third[:jan_1999_asset_values])
        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).second.year).to eq(rent_charges.first[:year] + 1)
        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).second.formula_rent_this_year).to eq((rent_charges.third[:formula_rent_this_year] * 0.99).round(2))
        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).second.rent_cap_this_year).to eq((rent_charges.third[:rent_cap_this_year] * 0.99).round(2))
        expect(rent_charges_gateway.all(rent_charges.first[:year] + 1).second.uprated_actual).to eq((rent_charges.third[:uprated_actual] * 0.99).round(2))
      end

      it 'saves fixed data row' do
        expect(Models::FixedDatum.all.first[:year]).to eq(rent_charges.first[:year] + 1)
        expect(Models::FixedDatum.all.first[:rc_uplift]).to eq(-0.01)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'given invalid attributes' do
      it 'returns invalid validation error' do
        invalid_attributes = { rc_uplift: 'abc', year: '12' }
        post '/rent-charges', params: invalid_attributes

        expect(json_response['successful']).to eq(false)
        expect(json_response['errors']).to eq(['invalid_year', 'invalid_rc_uplift'])
      end

      it 'returns missing validation error' do
        invalid_attributes = { rc_uplift: nil, year: nil }
        post '/rent-charges', params: invalid_attributes

        expect(json_response['successful']).to eq(false)
        expect(json_response['errors']).to eq(['missing_year', 'missing_rc_uplift', 'invalid_year', 'invalid_rc_uplift'])
      end
    end
  end
end
