# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RentCharges API', type: :request do
  let!(:fixed_data) { create_list(:cpi_fixed_datum, 10) }
  let(:fixed_datum_year) { fixed_data.first.year }

  describe 'GET /fixed-data' do
    before { get '/fixed-data' }

    it 'returns fixed data' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /fixed-data/:year' do
    before { get "/fixed-data/#{fixed_datum_year}" }

    context 'when the record exists' do
      it 'returns the fixed data' do
        expect(json).not_to be_empty
        expect(json['year']).to eq(fixed_datum_year)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST /fixed-data' do
    let(:valid_attributes) { { year: '2019-20', rc_uplift: 0.01 } }
    let(:save_fixed_data) { double(:save_fixed_data) }

    before do
      allow(SaveFixedData).to receive(:new).and_return(save_fixed_data)
      allow(save_fixed_data).to receive(:execute)
    end

    context 'when the request is valid' do
      before { post '/fixed-data', params: valid_attributes }

      it 'creates fixed data' do
        expect(save_fixed_data).to have_received(:execute).with(
          year: '2019-20',
          cpi: nil,
          real: nil,
          fr_uplift: nil,
          rc_factor: nil,
          rc_uplift: '0.01'
        )
        expect(json['year']).to eq('2019-20')
        expect(json['rc_uplift']).to eq('0.01')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end
end
