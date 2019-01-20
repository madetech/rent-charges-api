class UseCaseFactory
  def update_rent_details
    UpdateRentDetails.new(fixed_data_gateway: fixed_data_gateway, rent_detail_gateway: rent_detail_gateway)
  end

  def fixed_data_gateway
    FixedDataGateway.new
  end

  def rent_detail_gateway
    RentDetailGateway.new
  end
end
