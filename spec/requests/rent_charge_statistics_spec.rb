# frozen_string_literal: true

RSpec.describe 'RentCharges API', type: :request do
  describe 'POST /rent-charge-statistics' do
    let!(:rent_charges_same_year) { create_list(:rent_charge, 5) }
    let!(:rent_charges_different_years) { create_list(:rent_charge_different_years, 20) }
    let!(:more_rent_charges_same_year) { create_list(:more_rent_charge_same_year, 7) }
    let(:year) { rent_charges_same_year.first.year }
    let(:valid_attributes) { { year: rent_charges_same_year.first.year.to_s } }

    before do
      get "/rent-charge-statistics/#{year}"
    end

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

    it 'returns averages' do
      expect(json_response['average_formula_rent']).to eq(average(:formula_rent_this_year).to_s)
    end
  end
end
