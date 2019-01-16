# frozen_string_literal: true

describe ViewFixedData do
  context 'all' do
    it 'returns fixed data' do
      fixed_data_gateway = double(all: [
                                    {
                                      year: '2014-15',
                                      cpi: nil,
                                      real: nil,
                                      fr_uplift: nil,
                                      rc_factor: nil,
                                      rc_uplift: 0.0015
                                    },
                                    {
                                      year: '2015-16',
                                      cpi: nil,
                                      real: nil,
                                      fr_uplift: nil,
                                      rc_factor: nil,
                                      rc_uplift: 0.0005
                                    }
                                  ])

      view_fixed_data = described_class.new(fixed_data_gateway: fixed_data_gateway)

      response = view_fixed_data.execute
      expect(response[0][:year]).to eq('2014-15')
    end
  end

  context 'find by year' do
    it 'returns fixed data' do
      fixed_data_gateway = double(find_by_year: {
                                    year: '2014-15',
                                    rc_uplift: 0.0015
                                  })

      view_fixed_data = described_class.new(fixed_data_gateway: fixed_data_gateway)

      response = view_fixed_data.specific_year('2014-15')
      expect(response).to eq(year: '2014-15', rc_uplift: 0.0015)
    end

    it 'returns rc_uplift' do
      fixed_data_gateway = double(rc_uplift: 0.002 )

      view_fixed_data = described_class.new(fixed_data_gateway: fixed_data_gateway)

      response = view_fixed_data.rc_uplift('2014-15')
      expect(response).to eq(0.002)
    end
  end
end
