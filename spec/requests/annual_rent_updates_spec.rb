require 'rails_helper'

 RSpec.describe 'View annual rent updates API', type: :request do
    let!(:fixed_data) { create_list(:fixed_datum, 10) }

    let(:rc_uplift) { fixed_data.second.rc_uplift }

    let(:year_1) { Faker::Number.between(1, 10) + fixed_data.second.year }
    let(:year_2) { fixed_data.second.year }
    let(:year_3) { Faker::Number.between(11, 20) + fixed_data.second.year }

    let!(:rent_charges_data_year_1) { create_list(:rent_charge, 5, year: year_1) }
    let!(:rent_charges_data_year_2) { create_list(:rent_charge, 2, year: year_2) }
    let!(:rent_charges_data_year_3) { create_list(:rent_charge, 4, year: year_3) }

    describe 'GET /annual-rent-updates' do
        before { get '/annual-rent-updates' }
        
        context 'when the rent charge data exist' do
          it 'returns annual rent data' do

            expect(json_response).not_to be_empty
            expect(json_response.size).to eq(3)
          end
          
          it 'returns status code 200' do
            expect(response).to have_http_status(200)
          end
        end 

        context 'when the rent_charge_data does not exist' do
          let(:rent_charges_data_year_1) { [] }
          let!(:rent_charges_data_year_2) { [] }
          let!(:rent_charges_data_year_3) { [] }

          it 'returns no data' do
            expect(json_response).to be_empty
            expect(json_response.size).to eq(0)
          end
        end 
    end

    describe 'GET /annual-rent-updates/:year' do
      let(:year) { year_2 }

      before { get "/annual-rent-updates/#{year}" }

      context 'when the year record exist in rent charge data' do
        it 'returns annual rent updates data for second year in fixed data ' do
          expect(json_response).not_to be_empty
          expect(json_response['year']).to eq("#{year}")
          expect(json_response['rc_uplift']).to eq("#{rc_uplift}")
          expect(json_response['no_of_accounts']).to eq(2)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end

      context 'when the year record does not exist in rent charge data' do
        let!(:year) { 1999 }

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      
        it 'returns error' do
          expect(json_response['errors']).to eq(['no_record_found'])
        end
      end 

      context 'given invalid year' do
        let!(:year) { '123' }

        it 'returns missing validation error' do
           expect(json_response['successful']).to eq(false)
           expect(json_response['errors']).to eq(['invalid_year','no_record_found'])
        end 
      end
    end
end 


