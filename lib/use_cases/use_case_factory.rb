class UseCaseFactory
  def update_rent_charges
    UpdateRentCharges.new(fixed_data_gateway: fixed_data_gateway, rent_charges_gateway: rent_charges_gateway)
  end

  def view_rent_charge_statistics
    RentChargeStatistics.new(rent_charges_gateway: rent_charges_gateway)
  end

  private

  def fixed_data_gateway
    FixedDataGateway.new
  end

  def rent_charges_gateway
    RentChargesGateway.new
  end
end
