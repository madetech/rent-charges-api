describe 'Update Rent Charges' do
  let(:fixed_data_gateway) { FixedDataGateway.new }
  let(:rent_detail_gateway) { RentDetailGateway.new }
  let(:update_rent_details) {
    UpdateRentDetails.new(fixed_data_gateway: fixed_data_gateway, rent_detail_gateway: rent_detail_gateway)
  }
  let(:fixed_data) { { year: '2015', rc_uplift: '0.00015' } }

  it 'creates rent charges' do
    #update_rent_details.execute(fixed_data)
  end
end
