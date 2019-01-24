# frozen_string_literal: true

RSpec.describe 'RentCharges API', type: :request do
  describe 'GET /rent-charge-statistics' do
    let!(:rent_charges_same_year) { create_list(:rent_charge, 5) }
    let!(:rent_charges_different_years) { create_list(:rent_charge_different_years, 20) }
    let!(:more_rent_charges_same_year) { create_list(:more_rent_charge_same_year, 7) }

    def average(value)
      sum = 0
      rent_charges_same_year.each do |rent_charge|
        sum += rent_charge[value]
      end

      more_rent_charges_same_year.each do |rent_charge|
        sum += rent_charge[value]
      end

      sum / (rent_charges_same_year.count + more_rent_charges_same_year.count)
    end

    context 'given valid year' do
      before do
        get "/rent-charge-statistics/#{year}"
      end

      let(:year) { rent_charges_same_year.first.year }
      let(:valid_attributes) { { year: rent_charges_same_year.first.year.to_s } }

      it 'returns averages' do
        expect(json_response['average_formula_rent']).to eq(average(:formula_rent_this_year).to_s)
        expect(json_response['average_rent_cap']).to eq(average(:rent_cap_this_year).to_s)
        expect(json_response['average_uprated_actual']).to eq(average(:uprated_actual).to_s)
      end
    end

    context 'given invalid year' do
      it 'returns missing validation error' do
        year = nil
        get "/rent-charge-statistics/#{year}"

        expect(json_response['successful']).to eq(false)
        expect(json_response['errors']).to eq(['missing_year', 'invalid_year'])
      end

      it 'returns invalid validation error' do
        year = '123'
        get "/rent-charge-statistics/#{year}"

        expect(json_response['successful']).to eq(false)
        expect(json_response['errors']).to eq(['invalid_year'])
      end
    end

    context 'no records for year' do
      it 'returns error' do
        year = '2012'
        get "/rent-charge-statistics/#{year}"

        expect(json_response['successful']).to eq(false)
        expect(json_response['errors']).to eq(['no_records_for_specified_year'])
      end
    end
  end
end
