class RentDetailGateway
  def save(rent_details)
    rent_details.each do |rent_detail|
      RentCharge.create(rent_detail)
    end
  end

  def all(year)
    RentCharge.where(year: year)
  end
end
