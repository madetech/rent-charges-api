# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RentCharges API', type: :request do
  describe 'POST /rent-charges' do
    let(:valid_attributes) { { rc_uplift: '0.01', year: '2013' } }
    let(:update_rent_details) { double(:update_rent_details) }

    before do
      allow(UpdateRentDetails).to receive(:new).and_return(update_rent_details)
      allow(update_rent_details).to receive(:execute)
    end

    before { post '/rent-charges', params: valid_attributes }

    it 'creates fixed data' do
      expect(update_rent_details).to have_received(:execute).with(
        year: '2013',
        rc_uplift: '0.01'
      )
      expect(json['year']).to eq('2013')
      expect(json['rc_uplift']).to eq('0.01')
    end

    it 'returns status code 201' do
      expect(response).to have_http_status(201)
    end
  end
end
