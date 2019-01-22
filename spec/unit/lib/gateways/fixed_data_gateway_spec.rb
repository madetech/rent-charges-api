describe FixedDataGateway do
  let(:fixed_data_gateway) { FixedDataGateway.new }

  let(:fixed_datum) { { 
    year: Faker::Number.between(2000, 2050),
    rc_uplift: Faker::Number.between(0, 1)
  } }

  it 'creates new row for year and uplift' do
    fixed_data_gateway.save(fixed_datum)
    fixed_data = Models::FixedDatum.all
    expect(fixed_data[0][:year]).to eq(fixed_datum[:year])
    expect(fixed_data[0][:rc_uplift]).to eq(fixed_datum[:rc_uplift])
  end
end
