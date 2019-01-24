class RentChargeStatistics
  def initialize(rent_charges_gateway:)
    @rent_charges_gateway = rent_charges_gateway
  end

  def execute(year:)
    @rent_charges = @rent_charges_gateway.all(year)
    {
      average_formula_rent: average(:formula_rent_this_year),
      average_rent_cap: average(:rent_cap_this_year),
      average_uprated_actual: average(:uprated_actual)
    }
  end

  attr_reader :rent_charges

  private

  def average(value)
    rent_charges.map(&value).sum / rent_charges.count
  end
end
