# frozen_string_literal: true

class RentChargesGateway
  def all
    RentCharge.all
  end

  def save(rent_details)
    RentCharge.create(rent_details)
  end

  def find_by_year(year)
    RentCharge.find_by(year: year)
  end
end
