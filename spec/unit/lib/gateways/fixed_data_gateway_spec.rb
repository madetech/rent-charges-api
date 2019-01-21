describe FixedDataGateway do
  let(:fixed_data_gateway) { FixedDataGateway.new }

  let(:fixed_data) { { year: 2011, rc_uplift: 0.00015 } }

  it 'creates new row for year and uplift' do
    fixed_data_gateway.save(fixed_data)
    fixed_data = fixed_data_gateway.all
    expect(fixed_data[0][:rc_uplift]).to eq(0.00015)
    expect(fixed_data[0][:year]).to eq(2011)
  end
end
