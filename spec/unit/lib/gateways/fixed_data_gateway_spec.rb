describe FixedDataGateway do
  let(:fixed_data_gateway) { FixedDataGateway.new }
  let(:fixed_datum) do 
    [
      { year: Faker::Number.between(2000, 2010), rc_uplift: Faker::Number.between(1, 2)},
      { year: Faker::Number.between(2011, 2020), rc_uplift: Faker::Number.between(3, 4)}
    ] 
  end

  it 'creates new row for year and uplift' do
    fixed_data_gateway.save(fixed_datum)
    fixed_data = fixed_data_gateway.all
    expect(fixed_data[0].year).to eq(fixed_datum[0][:year])
    expect(fixed_data[0].rc_uplift).to eq(fixed_datum[0][:rc_uplift])
    expect(fixed_data[1].year).to eq(fixed_datum[1][:year])
    expect(fixed_data[1].rc_uplift).to eq(fixed_datum[1][:rc_uplift])
  end

  it 'returns rc_uplift for the year'  do
    fixed_data_gateway.save(fixed_datum)
    rc_uplift = fixed_data_gateway.rc_uplift(fixed_datum[0][:year])
    expect(rc_uplift).to eq(fixed_datum[0][:rc_uplift])
  end

  it 'returns nil when the year doesnt exists' do
    fixed_data_gateway.save(fixed_datum)
    rc_uplift = fixed_data_gateway.rc_uplift(2050)
    expect(rc_uplift).to eq(nil)
  end
end 

