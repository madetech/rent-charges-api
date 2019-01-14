# frozen_string_literal: true

describe FixedDataGateway do
  let(:fixed_data_gateway) { FixedDataGateway.new }

  it 'can retrieve no items' do
    data = fixed_data_gateway.all
    expect(data).to eq([])
  end

  it 'can retrieve all items' do
    fixed_data = [
      {
        year: '2013-14',
        cpi: nil,
        real: nil,
        fr_uplift: nil,
        rc_factor: nil,
        rc_uplift: 0.01
      },
      {
        year: '2005-06',
        cpi: nil,
        real: nil,
        fr_uplift: nil,
        rc_factor: nil,
        rc_uplift: 0.0007
      }
    ]
    fixed_data.each { |data_row| fixed_data_gateway.save(data_row) }
    data = fixed_data_gateway.all

    expected_data = [
      {
        year: '2013-14',
        cpi: nil,
        real: nil,
        fr_uplift: nil,
        rc_factor: nil,
        rc_uplift: 0.01
      },
      {
        year: '2005-06',
        cpi: nil,
        real: nil,
        fr_uplift: nil,
        rc_factor: nil,
        rc_uplift: 0.0007
      }
    ]

    expect(data.length).to eq(2)
    expect(data[0][:year]).to eq(expected_data[0][:year])
    expect(data[0][:rc_uplift]).to eq(expected_data[0][:rc_uplift])
    expect(data[1][:year]).to eq(expected_data[1][:year])
    expect(data[1][:rc_uplift]).to eq(expected_data[1][:rc_uplift])
  end

  context 'specific year' do
    it 'can save and retrieve a record' do
      fixed_data = {
        year: '2010-2011',
        cpi: nil,
        real: nil,
        fr_uplift: nil,
        rc_factor: nil,
        rc_uplift: 0.0002
      }
      fixed_data_gateway.save(fixed_data)
      data = fixed_data_gateway.find_by_year(fixed_data[:year])

      expected_data = {
        year: '2010-2011',
        cpi: nil,
        real: nil,
        fr_uplift: nil,
        rc_factor: nil,
        rc_uplift: 0.0002
      }

      expect(data[:year]).to eq(expected_data[:year])
      expect(data[:cpi]).to eq(expected_data[:cpi])
      expect(data[:rc_uplift]).to eq(expected_data[:rc_uplift])
    end
  end
end
