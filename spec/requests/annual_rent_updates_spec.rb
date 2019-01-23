require 'rails_helper'

 RSpec.describe 'View annual rent updates API', type: :request do
    let!(:fixed_data) { create_list(:fixed_datum, 3) }
    let!(:year) { fixed_data.first.year }
    let!(:rc_uplift) { fixed_data.first.rc_uplift }
    let!(:rent_charge_data) {[
      create(:rent_charge, uprn: '1', year:fixed_data.first.year),
      create(:rent_charge, uprn: '1', year:2010),
      create(:rent_charge, uprn: '2', year:fixed_data.first.year),
      create(:rent_charge, uprn: '2', year:2010),
      create(:rent_charge, uprn: '3', year:fixed_data.first.year),
      create(:rent_charge, uprn: '3', year:2010)
    ]}

    describe 'GET /annual-rent-updates' do
        before { get '/annual-rent-updates' }
        
        context 'when the rent charge data exist' do
          it 'returns annual rent data' do
            expect(json_response).not_to be_empty
            expect(json_response.size).to eq(2)
          end
          
          it 'returns status code 200' do
            expect(response).to have_http_status(200)
          end
        end 

        context 'when the rent_charge_data does not exist' do
          let(:rent_charge_data) {[]}
          it 'returns no data' do
            expect(json_response).to be_empty
            expect(json_response.size).to eq(0)
          end
        end 
    end

    describe 'GET /annual-rent-updates/:year' do
      before { get "/annual-rent-updates/#{year}" }

      context 'when the year record exist in rent charge data' do
        it 'returns annual rent updates data' do
          expect(json_response).not_to be_empty
          expect(json_response['year']).to eq("#{year}")
          expect(json_response['rc_uplift']).to eq("#{rc_uplift}")
          expect(json_response['no_of_accounts']).to eq(3)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end

      context 'when the year record does not exist in rent charge data' do
        let(:year) { 2015 }

        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end

        it 'returns no record' do
          expect(json_response).to be_nil
        end
      end 
    end
end 
