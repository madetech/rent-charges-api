class RentChargesGateway
  def save(rent_charges)
    rent_charges.each do |rent_charge|
      RentCharge.create!(rent_charge)
    end
  end

  def all(year)
    RentCharge.where(year: year)
  end
end
