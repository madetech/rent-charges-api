# frozen_string_literal: true

RSpec.describe 'RentCharges API', type: :request do
  describe 'POST /rent-charges' do
    let(:rent_charges_gateway) { RentChargesGateway.new }

    let(:year) { Faker::Number.between(2000, 2050) }
    let(:valid_attributes) { { rc_uplift: '-0.01', year: (year + 1).to_s } }

    let(:property_type_enumerables) { Models::RentCharge.property_types }

    def property_types
      property_type_enumerables.map { |key, value| key }
    end

    def randomised_rent_charge
      Faker::Number.between(100, 200)
    end

    let(:rent_charges) { [
      { 
        uprn: Faker::Base.regexify(/[0-9]{3}[a-z]{3}/),
        address: Faker::Base.regexify(/[0-9]{1,2} [a-z]{5,10}/),
        address_2: Faker::Base.regexify(/[A-Z]{1}[a-z]{5,10}/),
        comments: Faker::Base.regexify(/[a-z ]{15}/),
        rr_count: Faker::Number.between(1, 3),
        property_type: property_types.sample,
        base_data_bed_size: Faker::Number.between(1, 3),
        bedroom_weight: Faker::Number.between(0, 1),
        mra_archetype: Faker::Base.regexify(/[a-z]{5,10}/),
        jan_1999_asset_values: Faker::Number.between(20000, 100000),
        year: year,
        removed: Faker::Boolean,
        formula_rent_this_year: randomised_rent_charge,
        rent_cap_this_year: randomised_rent_charge,
        uprated_actual: randomised_rent_charge
      },
      { 
        uprn: Faker::Base.regexify(/[0-9]{3}[a-z]{3}/),
        address: Faker::Base.regexify(/[0-9]{1,2} [a-z]{5,10}/),
        address_2: Faker::Base.regexify(/[A-Z]{1}[a-z]{5,10}/),
        comments: Faker::Base.regexify(/[a-z ]{15}/),
        rr_count: Faker::Number.between(1, 3),
        property_type: property_types.sample,
        base_data_bed_size: Faker::Number.between(1, 3),
        bedroom_weight: Faker::Number.between(0, 1),
        mra_archetype: Faker::Base.regexify(/[a-z]{5,10}/),
        jan_1999_asset_values: Faker::Number.between(20000, 100000),
        year: year - 23,
        removed: Faker::Boolean,
        formula_rent_this_year: randomised_rent_charge,
        rent_cap_this_year: randomised_rent_charge,
        uprated_actual: randomised_rent_charge
      },
      { 
        uprn: Faker::Base.regexify(/[0-9]{3}[a-z]{3}/),
        address: Faker::Base.regexify(/[0-9]{1,2} [a-z]{5,10}/),
        address_2: Faker::Base.regexify(/[A-Z]{1}[a-z]{5,10}/),
        comments: Faker::Base.regexify(/[a-z ]{15}/),
        rr_count: Faker::Number.between(1, 3),
        property_type: property_types.sample,
        base_data_bed_size: Faker::Number.between(1, 3),
        bedroom_weight: Faker::Number.between(0, 1),
        mra_archetype: Faker::Base.regexify(/[a-z]{5,10}/),
        jan_1999_asset_values: Faker::Number.between(20000, 100000),
        year: year,
        removed: Faker::Boolean,
        formula_rent_this_year: randomised_rent_charge,
        rent_cap_this_year: randomised_rent_charge,
        uprated_actual: randomised_rent_charge
      }
    ]}
    
    context 'given valid attributes' do

      before do
        rent_charges_gateway.save(rent_charges)
        post '/rent-charges', params: valid_attributes
      end

      let(:chosen_year) { rent_charges.first[:year] + 1 }

      it 'creates rent charges for new year' do
        expect(json_response['year']).to eq((chosen_year).to_s )
        expect(json_response['rc_uplift']).to eq('-0.01')

        expect(rent_charges_gateway.all(chosen_year).count).to eq(2)

        (0..1).each do |index|
          expect(rent_charges_gateway.all(chosen_year)[index].uprn).to eq(rent_charges[index + index*1][:uprn])
          expect(rent_charges_gateway.all(chosen_year)[index].address).to eq(rent_charges[index + index*1][:address])
          expect(rent_charges_gateway.all(chosen_year)[index].address_2).to eq(rent_charges[index + index*1][:address_2])
          expect(rent_charges_gateway.all(chosen_year)[index].comments).to eq(rent_charges[index + index*1][:comments])
          expect(rent_charges_gateway.all(chosen_year)[index].comments).to eq(rent_charges[index + index*1][:comments])
          expect(rent_charges_gateway.all(chosen_year)[index].rr_count).to eq(rent_charges[index + index*1][:rr_count])
          expect(rent_charges_gateway.all(chosen_year)[index].property_type).to eq(rent_charges[index + index*1][:property_type])
          expect(rent_charges_gateway.all(chosen_year)[index].base_data_bed_size).to eq(rent_charges[index + index*1][:base_data_bed_size])
          expect(rent_charges_gateway.all(chosen_year)[index].bedroom_weight).to eq(rent_charges[index + index*1][:bedroom_weight])
          expect(rent_charges_gateway.all(chosen_year)[index].mra_archetype).to eq(rent_charges[index + index*1][:mra_archetype])
          expect(rent_charges_gateway.all(chosen_year)[index].jan_1999_asset_values).to eq(rent_charges[index + index*1][:jan_1999_asset_values])
          expect(rent_charges_gateway.all(chosen_year)[index].year).to eq(chosen_year)
          expect(rent_charges_gateway.all(chosen_year)[index].formula_rent_this_year).to eq((rent_charges[index + index*1][:formula_rent_this_year] * 0.99).round(2))
          expect(rent_charges_gateway.all(chosen_year)[index].rent_cap_this_year).to eq((rent_charges[index + index*1][:rent_cap_this_year] * 0.99).round(2))
          expect(rent_charges_gateway.all(chosen_year)[index].uprated_actual).to eq((rent_charges[index + index*1][:uprated_actual] * 0.99).round(2))
        end
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
