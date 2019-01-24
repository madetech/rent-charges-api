describe RentChargeStatistics do  
  context 'non random test data' do
    let(:rent_charges) { [
      Domain::RentCharge.new(
        formula_rent_this_year: 10,
        rent_cap_this_year: 7,
        uprated_actual: 4),
      Domain::RentCharge.new(
        formula_rent_this_year: 5,
        rent_cap_this_year: 8,
        uprated_actual: 8),
      Domain::RentCharge.new(
        formula_rent_this_year: 15,
        rent_cap_this_year: 6,
        uprated_actual: 3)
    ] }

    let(:year) { 2014 }

    let(:rent_charges_gateway) { double(all: rent_charges) }
    let(:view_rent_charge_statistics) { 
      described_class.new(rent_charges_gateway: rent_charges_gateway) }

    it 'returns statistics for given year' do
      response = view_rent_charge_statistics.execute(year: year)
      expect(response).to eq({ 
        average_formula_rent: 10,
        average_rent_cap: 7,
        average_uprated_actual: 5
      })
    end
  end

  context 'random test data' do
    let(:rent_charges) { create_list(:rent_charge, 5) }
    let(:rent_charges_gateway) { double(all: rent_charges) }
    let(:year) { rent_charges.first.year }
    let(:view_rent_charge_statistics) { 
      described_class.new(rent_charges_gateway: rent_charges_gateway) }

    def average(value)
      sum = 0
      rent_charges.each do |rent_charge|
        sum += rent_charge[value]
      end
      sum / rent_charges.count
    end
  
    it 'returns statistics for given year' do
      response = view_rent_charge_statistics.execute(year: year)
      expect(response).to eq({ 
        average_formula_rent: average(:formula_rent_this_year),
        average_rent_cap: average(:rent_cap_this_year),
        average_uprated_actual: average(:uprated_actual)
      })
    end
  end
end
