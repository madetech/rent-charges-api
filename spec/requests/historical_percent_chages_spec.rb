require 'rails_helper'

 RSpec.describe 'View Historical percent changes API', type: :request do
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

  describe 'GET /historical-percent-change' do
      before { get '/historical-percent-change' }

      it 'returns historical data' do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)
      end
      
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
  end

  describe 'GET /historical-percent-change/:year' do
    before { get "/historical-percent-change/#{year}" }

    context 'when the record exists' do
      it 'returns the historical percentange change data' do
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
