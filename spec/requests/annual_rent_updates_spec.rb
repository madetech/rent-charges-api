require 'rails_helper'

 RSpec.describe 'View annual rent updates API', type: :request do
  let!(:rent_charge_data) {[
    create(:rent_charge, uprn: '1', year:2018),
    create(:rent_charge, uprn: '1', year:2015),
    create(:rent_charge, uprn: '2', year:2018),
    create(:rent_charge, uprn: '4', year:2018),
    create(:rent_charge, uprn: '2', year:2015),
    create(:rent_charge, uprn: '3', year:2018)
  ]}

  let!(:fixed_data) {[
    create(:fixed_datum, year:2018, rc_uplift:-2.0),
    create(:fixed_datum, year:2015, rc_uplift:-1.0) 
  ]}

  let(:year) { fixed_data.first.year }

  describe 'GET /annual-rent-updates' do
      before { get '/annual-rent-updates' }

      it 'returns annual rent data' do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)
      end
      
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
  end

  describe 'GET /annual-rent-updates/:year' do
    before { get "/annual-rent-updates/#{year}" }

    context 'when the record exists' do
      it 'returns annual rent updates data' do
        expect(json).not_to be_empty
        expect(json['year']).to eq('2018')
        expect(json['rc_uplift']).to eq('-2.0')
        expect(json['no_of_accounts']).to eq(4)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:year) { 2011 }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'returns no record' do
        expect(json).to be_nil
      end
    end 
  end
end 
